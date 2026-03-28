"""
Source instrumenter for database code coverage.

Parses stored procedure/function bodies and injects coverage instrumentation
at branch, block, and loop points. Uses regex-based tokenisation rather than
a full PEG grammar — control flow keywords are distinctive enough
to instrument reliably without a complete parser.

Supports PL/pgSQL (Postgres) and SQL/PSM (MySQL).
"""
import hashlib
import re
from dataclasses import dataclass, field
from enum import Enum
from typing import Optional


class TagType(Enum):
    BLOCK = "block"
    BRANCH = "branch"
    LOOP = "loop"


@dataclass
class Tag:
    """A coverage tag attached to a point in the source."""
    id: str
    tag_type: TagType
    line: int
    description: str

    def __hash__(self):
        return hash(self.id)


def _make_tag_id(oid: str, line: int, keyword: str) -> str:
    """Generate a deterministic 16-char hex tag id."""
    raw = f"{oid}:{line}:{keyword}"
    return hashlib.md5(raw.encode()).hexdigest()[:16]


# ---------------------------------------------------------------------------
# Tokeniser — splits PL/pgSQL source into tokens that preserve structure
# ---------------------------------------------------------------------------

class TokenType(Enum):
    DOLLAR_STRING = "dollar_string"
    SINGLE_STRING = "single_string"
    BLOCK_COMMENT = "block_comment"
    LINE_COMMENT = "line_comment"
    KEYWORD = "keyword"
    SEMICOLON = "semicolon"
    OTHER = "other"


@dataclass
class Token:
    type: TokenType
    value: str
    start: int  # offset in source
    line: int   # 1-based line number


# PL/pgSQL keywords we care about for instrumentation
_KEYWORDS = {
    "begin", "end", "if", "then", "elsif", "elseif", "else",
    "loop", "while", "for", "foreach", "exit", "continue",
    "when", "case", "return", "raise", "exception", "declare",
    "do", "repeat", "until", "leave", "iterate",
}

# Regex for dollar-quoted strings: $tag$ ... $tag$
_RE_DOLLAR_STRING = re.compile(
    r'(\$[a-zA-Z_]?[a-zA-Z0-9_]*\$)(.*?)\1', re.DOTALL
)

# Regex for single-quoted strings (with '' escapes)
_RE_SINGLE_STRING = re.compile(r"(?:E'|')((?:''|[^'])*)'")

# Block comments
_RE_BLOCK_COMMENT = re.compile(r'/\*.*?\*/', re.DOTALL)

# Line comments
_RE_LINE_COMMENT = re.compile(r'--[^\n]*')

# Keyword boundary: word that is exactly a keyword
_RE_KEYWORD = re.compile(
    r'\b(' + '|'.join(sorted(_KEYWORDS, key=len, reverse=True)) + r')\b',
    re.IGNORECASE
)


def _line_at_offset(source: str, offset: int) -> int:
    """Return 1-based line number for a character offset."""
    return source[:offset].count('\n') + 1


def tokenise(source: str) -> list[Token]:
    """
    Tokenise PL/pgSQL source into a flat list of tokens.
    Strings and comments are captured as opaque tokens so keywords
    inside them are not matched.
    """
    tokens = []
    pos = 0
    length = len(source)

    while pos < length:
        # Try dollar-quoted string
        m = _RE_DOLLAR_STRING.match(source, pos)
        if m:
            tokens.append(Token(TokenType.DOLLAR_STRING, m.group(0), pos, _line_at_offset(source, pos)))
            pos = m.end()
            continue

        # Try single-quoted string
        m = _RE_SINGLE_STRING.match(source, pos)
        if m:
            tokens.append(Token(TokenType.SINGLE_STRING, m.group(0), pos, _line_at_offset(source, pos)))
            pos = m.end()
            continue

        # Try block comment
        m = _RE_BLOCK_COMMENT.match(source, pos)
        if m:
            tokens.append(Token(TokenType.BLOCK_COMMENT, m.group(0), pos, _line_at_offset(source, pos)))
            pos = m.end()
            continue

        # Try line comment
        m = _RE_LINE_COMMENT.match(source, pos)
        if m:
            tokens.append(Token(TokenType.LINE_COMMENT, m.group(0), pos, _line_at_offset(source, pos)))
            pos = m.end()
            continue

        # Try keyword
        m = _RE_KEYWORD.match(source, pos)
        if m:
            # Verify word boundary: char before must not be alphanumeric/underscore
            if pos > 0 and (source[pos - 1].isalnum() or source[pos - 1] == '_'):
                tokens.append(Token(TokenType.OTHER, source[pos], pos, _line_at_offset(source, pos)))
                pos += 1
                continue
            tokens.append(Token(TokenType.KEYWORD, m.group(0).lower(), pos, _line_at_offset(source, pos)))
            pos = m.end()
            continue

        # Semicolon — own token type for clean statement boundary detection
        if source[pos] == ';':
            tokens.append(Token(TokenType.SEMICOLON, ';', pos, _line_at_offset(source, pos)))
            pos += 1
            continue

        # Accumulate other characters
        if tokens and tokens[-1].type == TokenType.OTHER:
            tokens[-1].value += source[pos]
        else:
            tokens.append(Token(TokenType.OTHER, source[pos], pos, _line_at_offset(source, pos)))
        pos += 1

    return tokens


# ---------------------------------------------------------------------------
# Instrumenter — walks token stream and injects coverage instrumentation
# ---------------------------------------------------------------------------

_TRACE_PREFIX = "COVER_ME"


def _pg_raise_branch(tag_id: str) -> str:
    return f"PERFORM public.cover_me_branch('{tag_id}'); "


def _pg_wrap_cond(tag_id: str, condition: str) -> str:
    return f"public.cover_me_cond('{tag_id}', ({condition}))"


def _mysql_raise_branch(tag_id: str) -> str:
    return f"INSERT INTO cover_me.trace (tag_id) VALUES ('{tag_id}'); "


def _mysql_wrap_cond(tag_id: str, condition: str) -> str:
    return f"cover_me.cover_me_cond('{tag_id}', ({condition}))"


@dataclass
class InstrumentResult:
    """Result of instrumenting a function body."""
    source: str
    tags: list[Tag] = field(default_factory=list)


def instrument(source: str, oid: str, engine: str = "postgres") -> InstrumentResult:
    """
    Instrument a function body with coverage tracking.

    Injects RAISE WARNING calls at:
    - BEGIN blocks (block coverage)
    - IF/ELSIF conditions (branch coverage — true/false)
    - ELSE blocks (branch coverage)
    - WHILE conditions (loop coverage — true/false)
    - FOR/FOREACH/LOOP bodies (loop coverage)
    - EXIT/CONTINUE statements (branch coverage)
    - RETURN/RAISE EXCEPTION statements (branch coverage)
    - EXCEPTION WHEN handlers (branch coverage)
    """
    tokens = tokenise(source)
    tags: list[Tag] = []
    result_parts: list[str] = []
    i = 0

    if engine == "mysql":
        raise_branch = _mysql_raise_branch
        wrap_cond = _mysql_wrap_cond
    else:
        raise_branch = _pg_raise_branch
        wrap_cond = _pg_wrap_cond

    # Track when we've just seen END so we skip the following IF/LOOP/CASE
    after_end = False
    # Track CASE expression depth so we don't inject into CASE ... ELSE
    case_depth = 0

    def _peek_keyword(offset: int) -> Optional[str]:
        """Look ahead for the next keyword token from index offset."""
        j = offset
        while j < len(tokens):
            if tokens[j].type == TokenType.KEYWORD:
                return tokens[j].value
            if tokens[j].type == TokenType.OTHER and tokens[j].value.strip():
                return None
            j += 1
        return None

    def _find_next_keyword(start: int) -> Optional[int]:
        """Find index of next keyword token from start."""
        j = start
        while j < len(tokens):
            if tokens[j].type == TokenType.KEYWORD:
                return j
            j += 1
        return None

    def _collect_until_keyword(start: int, stop_keywords: set[str]) -> tuple[str, int]:
        """Collect token text from start until a keyword in stop_keywords is found.
        Returns (collected_text, index_of_stop_keyword)."""
        parts = []
        j = start
        while j < len(tokens):
            if tokens[j].type == TokenType.KEYWORD and tokens[j].value in stop_keywords:
                return ''.join(parts), j
            parts.append(tokens[j].value)
            j += 1
        return ''.join(parts), j

    while i < len(tokens):
        tok = tokens[i]

        # --- END keyword: pass through and mark so we skip the next IF/LOOP/CASE ---
        if tok.type == TokenType.KEYWORD and tok.value == "end":
            after_end = True
            result_parts.append(tok.value)
            i += 1
            continue

        # If we just saw END, the next keyword (IF/LOOP/CASE) is part of
        # the END statement — pass it through without instrumenting
        if after_end and tok.type == TokenType.KEYWORD and tok.value in (
            "if", "loop", "case", "for", "while", "foreach", "repeat"
        ):
            after_end = False
            if tok.value == "case":
                case_depth -= 1
            result_parts.append(tok.value)
            i += 1
            continue

        # Clear after_end for non-keyword tokens (whitespace etc)
        if after_end and tok.type not in (TokenType.OTHER,):
            after_end = False
        elif after_end and tok.type == TokenType.OTHER and tok.value.strip():
            after_end = False

        # --- BEGIN block ---
        if tok.type == TokenType.KEYWORD and tok.value == "begin":
            tag_id = _make_tag_id(oid, tok.line, "begin")
            tags.append(Tag(tag_id, TagType.BLOCK, tok.line, "block"))
            result_parts.append(tok.value)
            i += 1
            # For MySQL, DECLARE must come before any executable statements
            # Skip past all DECLARE lines before injecting the branch tracker
            if engine == "mysql":
                # In MySQL, DECLARE must precede executable statements.
                # Skip past all DECLARE statements before injecting.
                while i < len(tokens):
                    if tokens[i].type == TokenType.OTHER and not tokens[i].value.strip():
                        result_parts.append(tokens[i].value)
                        i += 1
                        continue
                    if tokens[i].type == TokenType.KEYWORD and tokens[i].value == "declare":
                        # Pass through DECLARE and everything until semicolon
                        while i < len(tokens):
                            result_parts.append(tokens[i].value)
                            is_semi = tokens[i].type == TokenType.SEMICOLON
                            i += 1
                            if is_semi:
                                break
                        continue
                    break
                result_parts.append("\n  ")
            else:
                if i < len(tokens) and tokens[i].type == TokenType.OTHER and not tokens[i].value.strip():
                    result_parts.append(tokens[i].value)
                    i += 1
                else:
                    result_parts.append("\n  ")
            result_parts.append(raise_branch(tag_id))
            continue

        # --- IF condition ---
        if tok.type == TokenType.KEYWORD and tok.value == "if":
            result_parts.append(tok.value)
            i += 1
            # Collect everything until THEN
            cond_text, i = _collect_until_keyword(i, {"then"})
            cond_stripped = cond_text.strip()
            if cond_stripped:
                tag_id = _make_tag_id(oid, tok.line, "if")
                tags.append(Tag(tag_id, TagType.BRANCH, tok.line, "IF condition"))
                # Preserve leading whitespace from cond_text
                leading_ws = cond_text[:len(cond_text) - len(cond_text.lstrip())]
                result_parts.append(leading_ws + wrap_cond(tag_id, cond_stripped) + " ")
            else:
                result_parts.append(cond_text)
            continue

        # --- ELSIF condition ---
        if tok.type == TokenType.KEYWORD and tok.value in ("elsif", "elseif"):
            result_parts.append(tok.value)
            i += 1
            cond_text, i = _collect_until_keyword(i, {"then"})
            cond_stripped = cond_text.strip()
            if cond_stripped:
                tag_id = _make_tag_id(oid, tok.line, "elsif")
                tags.append(Tag(tag_id, TagType.BRANCH, tok.line, "ELSIF condition"))
                leading_ws = cond_text[:len(cond_text) - len(cond_text.lstrip())]
                result_parts.append(leading_ws + wrap_cond(tag_id, cond_stripped) + " ")
            else:
                result_parts.append(cond_text)
            continue

        # --- CASE expression tracking ---
        if tok.type == TokenType.KEYWORD and tok.value == "case":
            case_depth += 1
            result_parts.append(tok.value)
            i += 1
            continue

        # --- ELSE block ---
        if tok.type == TokenType.KEYWORD and tok.value == "else":
            if case_depth > 0:
                # CASE ... ELSE is an expression — cannot inject statements
                result_parts.append(tok.value)
                i += 1
                continue
            tag_id = _make_tag_id(oid, tok.line, "else")
            tags.append(Tag(tag_id, TagType.BRANCH, tok.line, "ELSE branch"))
            result_parts.append(tok.value)
            i += 1
            # Consume following whitespace; if none, inject a newline
            if i < len(tokens) and tokens[i].type == TokenType.OTHER and not tokens[i].value.strip():
                result_parts.append(tokens[i].value)
                i += 1
            else:
                result_parts.append("\n  ")
            result_parts.append(raise_branch(tag_id))
            continue

        # --- WHILE condition LOOP/DO ---
        if tok.type == TokenType.KEYWORD and tok.value == "while":
            result_parts.append(tok.value)
            i += 1
            cond_text, i = _collect_until_keyword(i, {"loop", "do"})
            cond_stripped = cond_text.strip()
            if cond_stripped:
                tag_id = _make_tag_id(oid, tok.line, "while")
                tags.append(Tag(tag_id, TagType.LOOP, tok.line, "WHILE condition"))
                leading_ws = cond_text[:len(cond_text) - len(cond_text.lstrip())]
                result_parts.append(leading_ws + wrap_cond(tag_id, cond_stripped) + " ")
            else:
                result_parts.append(cond_text)
            # Consume the LOOP or DO keyword
            if i < len(tokens) and tokens[i].type == TokenType.KEYWORD and tokens[i].value in ("loop", "do"):
                result_parts.append(tokens[i].value)
                i += 1
            continue

        # --- FOR ... IN ... LOOP ---
        if tok.type == TokenType.KEYWORD and tok.value == "for":
            tag_id = _make_tag_id(oid, tok.line, "for")
            tags.append(Tag(tag_id, TagType.LOOP, tok.line, "FOR loop"))
            result_parts.append(tok.value)
            i += 1
            # Collect until LOOP keyword
            text, i = _collect_until_keyword(i, {"loop"})
            result_parts.append(text)
            if i < len(tokens):
                # Emit LOOP keyword
                result_parts.append(tokens[i].value)
                i += 1
                # Consume whitespace; if none, inject a newline
                if i < len(tokens) and tokens[i].type == TokenType.OTHER and not tokens[i].value.strip():
                    result_parts.append(tokens[i].value)
                    i += 1
                else:
                    result_parts.append("\n    ")
                result_parts.append(raise_branch(tag_id))
            continue

        # --- FOREACH ... IN ARRAY ... LOOP ---
        if tok.type == TokenType.KEYWORD and tok.value == "foreach":
            tag_id = _make_tag_id(oid, tok.line, "foreach")
            tags.append(Tag(tag_id, TagType.LOOP, tok.line, "FOREACH loop"))
            result_parts.append(tok.value)
            i += 1
            text, i = _collect_until_keyword(i, {"loop"})
            result_parts.append(text)
            if i < len(tokens):
                result_parts.append(tokens[i].value)
                i += 1
                if i < len(tokens) and tokens[i].type == TokenType.OTHER and not tokens[i].value.strip():
                    result_parts.append(tokens[i].value)
                    i += 1
                result_parts.append(raise_branch(tag_id))
            continue

        # --- Bare LOOP (unconditional) ---
        if tok.type == TokenType.KEYWORD and tok.value == "loop":
            # Only instrument if not already consumed by WHILE/FOR/FOREACH
            tag_id = _make_tag_id(oid, tok.line, "loop")
            tags.append(Tag(tag_id, TagType.LOOP, tok.line, "LOOP"))
            result_parts.append(tok.value)
            i += 1
            if i < len(tokens) and tokens[i].type == TokenType.OTHER and not tokens[i].value.strip():
                result_parts.append(tokens[i].value)
                i += 1
            result_parts.append(raise_branch(tag_id))
            continue

        # --- EXIT / CONTINUE / LEAVE / ITERATE ---
        if tok.type == TokenType.KEYWORD and tok.value in ("exit", "continue", "leave", "iterate"):
            tag_id = _make_tag_id(oid, tok.line, tok.value)
            tags.append(Tag(tag_id, TagType.BRANCH, tok.line, f"{tok.value.upper()} statement"))
            result_parts.append(raise_branch(tag_id) + tok.value)
            i += 1
            continue

        # --- REPEAT (MySQL do-while) ---
        if tok.type == TokenType.KEYWORD and tok.value == "repeat":
            tag_id = _make_tag_id(oid, tok.line, "repeat")
            tags.append(Tag(tag_id, TagType.LOOP, tok.line, "REPEAT loop"))
            result_parts.append(tok.value)
            i += 1
            if i < len(tokens) and tokens[i].type == TokenType.OTHER and not tokens[i].value.strip():
                result_parts.append(tokens[i].value)
                i += 1
            result_parts.append(raise_branch(tag_id))
            continue

        # --- RETURN ---
        if tok.type == TokenType.KEYWORD and tok.value == "return":
            tag_id = _make_tag_id(oid, tok.line, "return")
            tags.append(Tag(tag_id, TagType.BRANCH, tok.line, "RETURN statement"))
            result_parts.append(raise_branch(tag_id) + tok.value)
            i += 1
            continue

        # --- RAISE EXCEPTION ---
        if tok.type == TokenType.KEYWORD and tok.value == "raise":
            next_kw = _peek_keyword(i + 1)
            if next_kw == "exception":
                tag_id = _make_tag_id(oid, tok.line, "raise_exception")
                tags.append(Tag(tag_id, TagType.BRANCH, tok.line, "RAISE EXCEPTION"))
                result_parts.append(raise_branch(tag_id) + tok.value)
                i += 1
                continue
            # Non-exception RAISE (WARNING/NOTICE/etc) — don't instrument
            result_parts.append(tok.value)
            i += 1
            continue

        # --- EXCEPTION WHEN handler ---
        if tok.type == TokenType.KEYWORD and tok.value == "exception":
            result_parts.append(tok.value)
            i += 1
            continue

        # --- WHEN inside EXCEPTION block or CASE ---
        if tok.type == TokenType.KEYWORD and tok.value == "when":
            # We need context to know if this is EXCEPTION WHEN, CASE WHEN,
            # EXIT WHEN, or CONTINUE WHEN. For EXCEPTION/CASE WHEN we inject
            # a block tag after THEN. EXIT/CONTINUE WHEN are handled above.
            result_parts.append(tok.value)
            i += 1
            continue

        # --- Everything else: pass through ---
        result_parts.append(tok.value)
        i += 1

    return InstrumentResult(source=''.join(result_parts), tags=tags)
