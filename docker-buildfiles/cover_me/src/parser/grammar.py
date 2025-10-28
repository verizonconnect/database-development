import pyparsing as pp
import re
from pyparsing import (
    CaselessKeyword, Forward, Group, ZeroOrMore, Optional, Combine, MatchFirst
)
from . import nodes

# --- Parse Action Helper (Kept at the top) ---

def create_node_action(node_class, original_text_ref):
    """
    A factory that creates a pyparsing parse action.
    This action will instantiate a node from `nodes.py`.
    """
    def parse_action(s, loc, toks):
        # 1. Create the node instance
        # Pass the original text (stored in the mutable list ref)
        node = node_class(s, loc, toks, original_text_ref[0])
        
        # 2. Set the parent/child links
        # This is crucial for the .parent and .named() methods
        node.parent = node 
        
        return node
    return parse_action

# --- Keyword Helper ---

def define_keywords(node_action_helper):
    """Defines all keywords and suppresses them, applying parse actions for TKeyword where needed."""
    
    # Common suppressed elements
    SEMI = pp.Literal(";").suppress()
    LBRACKET = pp.Literal("[").suppress()
    RBRACKET = pp.Literal("]").suppress()
    LPAREN = pp.Literal("(").suppress()
    RPAREN = pp.Literal(")").suppress()
    COLON = pp.Literal(":").suppress()
    COMMA = pp.Literal(",").suppress()
    DOT = pp.Literal(".").suppress()

    # Define all keywords. We use CaselessKeyword, which handles word boundaries.
    # Apply node action only to keywords required for context (like BEGIN/END) 
    # and return suppressed versions of all others.
    
    def kw(name, node_class=None):
        element = pp.CaselessKeyword(name).suppress()
        if node_class:
            element.set_parse_action(node_action_helper(node_class))
        return element

    keywords = {
        "kwALIAS": kw("alias"), "kwALTER": kw("alter"), "kwARRAY": kw("array"), 
        "kwAS": kw("as"), "kwASSIGN": pp.one_of(":= =").suppress(),
        "kwBEGIN": kw("begin", nodes.TKeyword), "kwBY": kw("by"), 
        "kwCASE": kw("case"), "kwCLOSE": kw("close"), "kwCOLLATE": kw("collate"),
        "kwCOMMIT": kw("commit"), "kwCONSTANT": kw("constant"), 
        "kwCONTINUE": kw("continue"), "kwCOPY": kw("copy"), 
        "kwCREATE": kw("create"), "kwCURSOR": kw("cursor"), 
        "kwDEBUG": kw("debug"), "kwDECLARE": kw("declare"), 
        "kwDEFAULT": kw("default"), "kwDELETE": kw("delete"),
        "kwDIAGNOSTICS": kw("diagnostics"), "kwDROP": kw("drop"), 
        "kwELSE": kw("else", nodes.TKeyword), 
        "kwELSIF": pp.one_of("elsif elseif", caseless=True).suppress().set_parse_action(node_action_helper(nodes.TKeyword)),
        "kwEND": kw("end", nodes.TKeyword), "kwEXCEPTION": kw("exception"), 
        "kwEXECUTE": kw("execute"), "kwEXIT": kw("exit"), 
        "kwFETCH": kw("fetch"), "kwFOR": kw("for"), "kwFOREACH": kw("foreach"),
        "kwFROM": kw("from"), "kwGET": kw("get"), "kwIF": kw("if"), 
        "kwIN": kw("in"), "kwINFO": kw("info"), "kwINSERT": kw("insert"), 
        "kwINTO": kw("into"), "kwIS": kw("is"), "kwLOCK": kw("lock"), 
        "kwLOG": kw("log"), "kwLOOP": kw("loop"), "kwMOVE": kw("move"), 
        "kwNEXT": kw("next"), "kwNO": kw("no"), "kwNOT": kw("not"),
        "kwNOTIFY": kw("notify"), "kwNOTICE": kw("notice"), "kwNULL": kw("null"), 
        "kwOPEN": kw("open"), "kwOR": kw("or"), "kwPERFORM": kw("perform"),
        "kwQUERY": kw("query"), "kwRAISE": kw("raise"), "kwRENAME": kw("rename"), 
        "kwRESULTOID": kw("result_oid"), "kwRETURN": kw("return"), 
        "kwREVERSE": kw("reverse"), "kwROWCOUNT": kw("row_count"), 
        "kwSCROLL": kw("scroll"), "kwSELECT": kw("select"), "kwSET": kw("set"), 
        "kwSTACKED": kw("stacked"), "kwSTART": kw("start"), "kwSTRICT": kw("strict"),
        "kwTHEN": kw("then", nodes.TKeyword), "kwTO": kw("to"), "kwTRUNCATE": kw("truncate"),
        "kwTYPE": kw("type"), "kwUPDATE": kw("update"), "kwWARNING": kw("warning"), 
        "kwWHEN": kw("when", nodes.TKeyword), "kwWHILE": kw("while"), 
        "kwWITH": kw("with"), "kwCAST": kw("cast")
    }
    
    # Add common suppressed elements
    keywords.update({
        "SEMI": SEMI, "LBRACKET": LBRACKET, "RBRACKET": RBRACKET, 
        "LPAREN": LPAREN, "RPAREN": RPAREN, "COLON": COLON, 
        "COMMA": COMMA, "DOT": DOT
    })
    
    return keywords

# --- Grammar Definition Wrapper ---

def get_parser(original_text_ref):
    """
    Builds and returns the full PL/pgSQL pyparsing grammar.
    """
    pp.ParserElement.set_default_whitespace_chars("")
    
    # Helper to apply the node creation action, curried with the original_text_ref
    node = lambda node_class: create_node_action(node_class, original_text_ref)
    
    # Load all keywords and suppressed elements
    K = define_keywords(node)
    
    # Extract suppressed elements
    SEMI, LBRACKET, RBRACKET, LPAREN, RPAREN, COMMA, DOT = \
        K["SEMI"], K["LBRACKET"], K["RBRACKET"], K["LPAREN"], K["RPAREN"], K["COMMA"], K["DOT"]
#pp.MatchFirst([kwINSERT, kwSELECT, kwUPDATE, kwDELETE, kwPERFORM, kwEXECUTE, kwOPEN, kwCLOSE, kwLOCK, kwFETCH, kwMOVE, kwTRUNCATE, kwCREATE, kwDROP, kwALTER, kwCOMMIT, kwCOPY, kwSET, kwSTART, kwNOTIFY, kwWITH])
    # Extract keywords
    kwALIAS, kwALTER, kwAS, kwASSIGN, kwARRAY, kwBEGIN, kwBY, kwCASE, kwCLOSE, kwCOLLATE, kwCOMMIT, kwCONSTANT, kwCONTINUE, kwCOPY, kwCREATE, kwCURSOR, kwDEBUG, kwDEFAULT, kwDECLARE, kwDELETE, kwDIAGNOSTICS, kwDROP, kwELSE, kwELSIF, kwEND, kwEXCEPTION, kwEXECUTE, kwEXIT, kwFETCH, kwFOR, kwFOREACH, kwFROM, kwGET, kwIF, kwIN, kwINFO, kwINSERT, kwINTO, kwIS, kwLOCK, kwLOG, kwLOOP, kwMOVE, kwNEXT, kwNO, kwNOT, kwNOTICE, kwNOTIFY, kwNULL, kwOPEN, kwOR, kwPERFORM, kwQUERY, kwRAISE, kwRENAME, kwRESULTOID, kwRETURN, kwREVERSE, kwROWCOUNT, kwSCROLL, kwSELECT, kwSET, kwSTACKED, kwSTART, kwSTRICT, kwTHEN, kwTO, kwTRUNCATE, kwTYPE, kwUPDATE, kwWARNING, kwWHEN, kwWHILE, kwWITH, kwCAST = \
        K["kwALIAS"], K["kwALTER"], K["kwAS"], K["kwASSIGN"], K["kwARRAY"], K["kwBEGIN"], K["kwBY"], K["kwCASE"], K["kwCLOSE"], K["kwCOLLATE"], ["kwCOMMIT"], K["kwCONSTANT"], K["kwCONTINUE"], K["kwCOPY"], K["kwCREATE"], K["kwCURSOR"], K["kwDEBUG"], K["kwDEFAULT"], K["kwDECLARE"], K["kwDELETE"], K["kwDIAGNOSTICS"], K["kwDROP"], K["kwELSE"], K["kwELSIF"], K["kwEND"], K["kwEXCEPTION"], K["kwEXECUTE"], K["kwEXIT"], K["kwFETCH"], K["kwFOR"], K["kwFOREACH"], K["kwFROM"], K["kwGET"], K["kwIF"], K["kwIN"], K["kwINFO"], K["kwINSERT"], K["kwINTO"], K["kwIS"], K["kwLOCK"], K["kwLOG"], K["kwLOOP"], K["kwMOVE"], K["kwNEXT"], K["kwNO"], K["kwNOT"], K["kwNOTICE"], K["kwNOTIFY"], K["kwNULL"], K["kwOPEN"], K["kwOR"], K["kwPERFORM"], K["kwQUERY"], K["kwRAISE"], K["kwRENAME"], K["kwRESULTOID"], K["kwRETURN"], K["kwREVERSE"], K["kwROWCOUNT"], K["kwSCROLL"], K["kwSELECT"], K["kwSET"], K["kwSTACKED"], K["kwSTART"], K["kwSTRICT"], K["kwTHEN"], K["kwTO"], K["kwTRUNCATE"], K["kwTYPE"], K["kwUPDATE"], K["kwWARNING"], K["kwWHEN"], K["kwWHILE"], K["kwWITH"], K["kwCAST"]

    # --- Forward Declarations (Explicit and Safe) ---
    # This prevents the UnboundLocalError by explicitly assigning each forward.
    lValue = pp.Forward()
    start = pp.Forward()
    block = pp.Forward()
    tSpace = pp.Forward()
    statement = pp.Forward()
    keyword = pp.Forward()
    sqlKeyword = pp.Forward()
    tEOF = pp.Forward()
    tString = pp.Forward()
    tBinary = pp.Forward()
    tHex = pp.Forward()
    tNumber = pp.Forward()
    tType = pp.Forward()
    rType = pp.Forward()
    tLiteral = pp.Forward()
    tIdentifier = pp.Forward()
    tLabel = pp.Forward()
    tLabelDefinition = pp.Forward()
    expressionUntilSemiColon = pp.Forward()
    expressionUntilClosingBracket = pp.Forward()
    expressionUntilThen = pp.Forward()
    expressionUntilWhen = pp.Forward()
    expressionUntilLoop = pp.Forward()
    stmtDeclare = pp.Forward()
    varDeclaration = pp.Forward()
    varDeclarationMisc = pp.Forward()
    varDeclarationCursor = pp.Forward()
    identifierList = pp.Forward()
    blockExceptions = pp.Forward()
    exceptionCase = pp.Forward()
    caseWhen = pp.Forward()
    condWhen = pp.Forward()
    stmtContinue = pp.Forward()
    stmtReturn = pp.Forward()
    stmtRaise = pp.Forward()
    stmtExecSql = pp.Forward()
    stmtGetDiag = pp.Forward()
    stmtNull = pp.Forward()
    stmtAssignment = pp.Forward()
    stmtIf = pp.Forward()
    stmtElse = pp.Forward() 
    stmtCase = pp.Forward()
    stmtLoop = pp.Forward()
    stmtWhileLoop = pp.Forward()
    stmtForLoop = pp.Forward()
    stmtForEachLoop = pp.Forward()
    stmtForSql = pp.Forward()
    stmtExit = pp.Forward()
    stubNode = pp.Forward()
    innerStatement = pp.Forward()
    block_with_label = pp.Forward()
    block_without_label = pp.Forward()

    # --- 2. Whitespace and Tokens ---
    
    # Define ws
    ws = pp.Regex(r'[ \t\n\v\f\r]+').suppress()
    ws_literal = pp.Regex(r'[ \t\n\v\f\r]+')
    stubNode <<= pp.Empty().set_parse_action(node(nodes.StubNode)) 
    lineComment = pp.Literal("--") + pp.rest_of_line()
    blockComment = pp.c_style_comment
    tComment = (lineComment | blockComment)
    tSpace <<= pp.OneOrMore(ws)
    
    # Identifiers and Labels
    quotedIdentifier = pp.Combine(pp.OneOrMore(pp.QuotedString('"')))
    # The list of all keywords for negative lookahead
    ALL_KEYWORDS = [v for k, v in K.items() if k.startswith("kw")]
    
    # Define the main 'keyword' rule
    keyword <<= pp.MatchFirst(ALL_KEYWORDS)
    
    # The logic for unquotedIdentifier then works correctly:
    unquotedIdentifier = pp.NotAny(keyword) +pp.Regex(r"[a-z\x80-\xFF_][a-z\x80-\xFF_0-9$]*")
    tIdentifier <<= (quotedIdentifier | unquotedIdentifier).set_parse_action(node(nodes.TIdentifier)) 
    tLabel <<= tIdentifier.set_parse_action(node(nodes.TLabel)) 
    tLabelDefinition <<= (
        pp.Literal("<<").suppress() + pp.Optional(tSpace) + tLabel + pp.Optional(tSpace) + pp.Literal(">>").suppress()
    ).set_parse_action(node(nodes.TLabel)) 
    
    # Strings 
    dollarQuotedString = pp.Regex(r"\$([a-zA-Z_]\w*)?\$.*?\$\1\$", flags=re.DOTALL).set_parse_action(node(nodes.TString))
    eString = pp.Regex(r"E'(''|[^'])*'", flags=re.IGNORECASE).set_parse_action(node(nodes.TString))
    standardString = pp.QuotedString("'", esc_quote="''").set_parse_action(node(nodes.TString))
    tString <<= pp.MatchFirst([dollarQuotedString, eString, standardString])
    
    # Numbers
    tBinary <<= pp.Regex(r"b'[01]+'").set_parse_action(node(nodes.Terminal)) 
    tHex <<= pp.Regex(r"x'[0-9a-fA-F]+'").set_parse_action(node(nodes.Terminal))
    decimal_form1 = pp.Regex(r"[+-]?\.\d+([eE][+-]?\d+)?").set_parse_action(node(nodes.Terminal))
    decimal_form2 = pp.Regex(r"[+-]?\d+\.\d*([eE][+-]?\d+)?").set_parse_action(node(nodes.Terminal))
    decimal_form3 = pp.Regex(r"[+-]?\d+\.?([eE][+-]?\d+)?").set_parse_action(node(nodes.Terminal))
    tNumber <<= pp.MatchFirst([tBinary, tHex, decimal_form1, decimal_form2, decimal_form3])
    
    # Types and Literals
    rType_atom = pp.Regex(r"[^()\[\]]+")
    rType <<= pp.Combine(pp.ZeroOrMore((LPAREN + rType + RPAREN) | (LBRACKET + rType + RBRACKET) | rType_atom))
    
    type_start = pp.Regex(r"[a-z\x80-\xFF_]")
    type_part1 = LPAREN + rType + RPAREN
    type_part2 = LBRACKET + rType + RBRACKET
    type_part3 = pp.Regex(r"[a-z\x80-\xFF_0-9$%]+\.?")
    type_part4 = ws_literal + pp.NotAny(kwAS | kwNOT | kwASSIGN | kwDEFAULT)
    tType <<= pp.Combine(
        type_start + pp.ZeroOrMore(type_part1 | type_part2 | type_part3 | type_part4)
    ).set_parse_action(node(nodes.TDatatype))
    
    string_cast_op = pp.Optional(pp.Optional(tSpace) + "::" + pp.Optional(tSpace) + tType)
    number_cast_op = pp.Optional(pp.Optional(tSpace) + "::" + pp.Optional(tSpace) + tType)
    string_with_cast = tString + string_cast_op
    number_with_cast = tNumber + number_cast_op
    cast_string = (kwCAST + pp.Optional(tSpace) + LPAREN + pp.Optional(tSpace) + tString + tSpace + kwAS + tSpace + tType + pp.Optional(tSpace) + RPAREN)
    cast_number = (kwCAST + pp.Optional(tSpace) + LPAREN + pp.Optional(tSpace) + tNumber + tSpace + kwAS + tSpace + tType + pp.Optional(tSpace) + RPAREN)
    tLiteral <<= pp.MatchFirst([cast_string, cast_number, string_with_cast, number_with_cast])


    # --- 3. Expression Rules ---
    
    # lValue (Apply Assignable action)
    lValue <<= (
        tIdentifier +
        pp.ZeroOrMore(LBRACKET + expressionUntilClosingBracket + RBRACKET) +
        pp.ZeroOrMore(DOT + lValue)
    ).set_parse_action(node(nodes.Assignable))
    
    # Scan-Until Expressions (Apply Expression action)
    expr_atom_semicolon = tString | pp.NotAny(SEMI) + pp.Regex(r".", flags=re.DOTALL)
    expressionUntilSemiColon <<= (
        pp.Optional(tSpace) + pp.Combine(pp.ZeroOrMore(expr_atom_semicolon)).set_results_name("expr") +
        pp.Optional(tSpace) + pp.FollowedBy(SEMI)
    ).set_parse_action(node(nodes.Expression))
    
    expr_atom_bracket = tString | pp.NotAny(RBRACKET) + pp.Regex(r".", flags=re.DOTALL)
    expressionUntilClosingBracket <<= (
        pp.Optional(tSpace) + pp.Combine(pp.OneOrMore(expr_atom_bracket)).set_results_name("expr") +
        pp.Optional(tSpace) + pp.FollowedBy(RBRACKET)
    ).set_parse_action(node(nodes.Expression))
    
    expr_atom_then = tString | pp.NotAny(kwTHEN) + pp.Regex(r".", flags=re.DOTALL)
    expressionUntilThen <<= (
        pp.Optional(tSpace) + pp.Combine(pp.OneOrMore(expr_atom_then)).set_results_name("expr") +
        pp.FollowedBy(pp.Optional(tSpace) + kwTHEN)
    ).set_parse_action(node(nodes.Expression))
    
    expr_atom_when = tString | pp.NotAny(kwWHEN) + pp.Regex(r".", flags=re.DOTALL)
    expressionUntilWhen <<= (
        pp.Optional(tSpace) + pp.Combine(pp.OneOrMore(expr_atom_when)).set_results_name("expr") +
        pp.FollowedBy(tSpace + kwWHEN)
    ).set_parse_action(node(nodes.Expression))
    
    expr_atom_loop = tString | pp.NotAny(kwLOOP) + pp.Regex(r".", flags=re.DOTALL)
    expressionUntilLoop <<= (
        pp.Optional(tSpace) + pp.Combine(pp.OneOrMore(expr_atom_loop)).set_results_name("expr") +
        pp.FollowedBy(tSpace + kwLOOP)
    ).set_parse_action(node(nodes.Expression))

    # --- 4. Declaration and Exception Rules ---

    identifierList <<= tIdentifier + pp.ZeroOrMore(pp.Optional(tSpace) + COMMA + pp.Optional(tSpace) + tIdentifier)

    varDeclarationMisc <<= (
        tIdentifier.set_results_name("name") + tSpace + pp.Optional(kwCONSTANT + tSpace) +
        tType.set_results_name("type") +
        pp.Optional(tSpace + kwCOLLATE + tIdentifier) +
        pp.Optional(tSpace + kwNOT + tSpace + kwNULL) +
        pp.Optional(pp.Optional(tSpace) + (kwASSIGN | kwDEFAULT) + pp.Optional(tSpace) + expressionUntilSemiColon.set_results_name("rval")) +
        pp.Optional(tSpace) + SEMI + pp.Optional(tSpace)
    ).set_parse_action(node(nodes.Terminal))

    varDeclarationCursor <<= (
        tIdentifier.set_results_name("name") + tSpace +
        pp.Optional(pp.Optional(kwNO + tSpace) + kwSCROLL + tSpace) +
        kwCURSOR + tSpace +
        expressionUntilSemiColon.set_results_name("rval") +
        pp.Optional(tSpace) + SEMI + pp.Optional(tSpace)
    ).set_parse_action(node(nodes.Terminal))

    varDeclaration <<= varDeclarationMisc | varDeclarationCursor
    stmtDeclare <<= kwDECLARE + tSpace + pp.ZeroOrMore(varDeclaration)

    exceptionCase <<= (
        kwWHEN + tSpace + expressionUntilThen.set_results_name("cond") + tSpace + 
        kwTHEN + tSpace + stubNode + pp.ZeroOrMore(statement).set_results_name("body")
    ).set_parse_action(node(nodes.Catch))

    blockExceptions <<= kwEXCEPTION + tSpace + pp.ZeroOrMore(exceptionCase)

    caseWhen <<= (
        kwWHEN + tSpace + expressionUntilThen.set_results_name("cond") + tSpace + 
        kwTHEN + tSpace + stubNode + pp.ZeroOrMore(statement).set_results_name("body")
    ).set_parse_action(node(nodes.CaseWhen))

    condWhen <<= (
        kwWHEN + tSpace + stubNode + expressionUntilThen.set_results_name("cond") + tSpace + 
        kwTHEN + tSpace + stubNode + pp.ZeroOrMore(statement).set_results_name("body")
    ).set_parse_action(node(nodes.CondWhen))

    # --- 5. Statement Rules ---

    # Simple Statements
    stmtNull <<= (kwNULL + pp.Optional(tSpace) + SEMI).set_parse_action(node(nodes.Terminal))
    
    stmtAssignment <<= (
        lValue.set_results_name("lval") + pp.Optional(tSpace) + kwASSIGN + pp.Optional(tSpace) +
        expressionUntilSemiColon.set_results_name("rval") + pp.Optional(tSpace) + SEMI
    ).set_parse_action(node(nodes.Assignment))
    
    # The list of keywords relevant for SQL commands
    SQL_KEYWORDS = [
        K["kwINSERT"], K["kwSELECT"], K["kwUPDATE"], K["kwDELETE"], K["kwPERFORM"], 
        K["kwEXECUTE"], K["kwOPEN"], K["kwCLOSE"], K["kwLOCK"], K["kwFETCH"], 
        K["kwMOVE"], K["kwTRUNCATE"], K["kwCREATE"], K["kwDROP"], K["kwALTER"], 
        K["kwCOMMIT"], K["kwCOPY"], K["kwSET"], K["kwSTART"], K["kwNOTIFY"], K["kwWITH"]
    ]
    
    # Define sqlKeyword using the list
    sqlKeyword <<= pp.MatchFirst(SQL_KEYWORDS)
    stmtExecSql <<= (sqlKeyword + expressionUntilSemiColon.set_results_name("expr") + SEMI).set_parse_action(node(nodes.Sql))
    
    stmtGetDiag <<= (
        kwGET + tSpace + pp.Optional(kwSTACKED + tSpace) + kwDIAGNOSTICS + tSpace + 
        expressionUntilSemiColon.set_results_name("expr") + SEMI
    ).set_parse_action(node(nodes.Expression))

    # Continue/Exit Statements
    stmtContinue_simple = (
        stubNode.set_results_name("bodyStub") + kwCONTINUE + pp.Optional(tSpace + tLabel.set_results_name("label")) + pp.Optional(tSpace) + SEMI
    ).set_parse_action(node(nodes.Continue))
    stmtContinue_when = (
        kwCONTINUE + pp.Optional(tSpace + tLabel.set_results_name("label")) + tSpace +
        kwWHEN + tSpace + stubNode.set_results_name("condStub") + expressionUntilSemiColon.set_results_name("cond") + SEMI
    ).set_parse_action(node(nodes.ContinueWhen))
    stmtContinue <<= stmtContinue_simple | stmtContinue_when

    stmtExit_simple = (
        stubNode.set_results_name("bodyStub") + kwEXIT + pp.Optional(tSpace + tLabel.set_results_name("label")) + pp.Optional(tSpace) + SEMI
    ).set_parse_action(node(nodes.Exit))
    stmtExit_when = (
        kwEXIT + pp.Optional(tSpace + tLabel.set_results_name("label")) + tSpace +
        kwWHEN + tSpace + stubNode.set_results_name("condStub") + expressionUntilSemiColon.set_results_name("cond") + SEMI
    ).set_parse_action(node(nodes.ExitWhen))
    stmtExit <<= stmtExit_simple | stmtExit_when
    
    # Return Statement
    return_expr = pp.MatchFirst([
        pp.FollowedBy(SEMI),
        tSpace + kwNEXT + tSpace + expressionUntilSemiColon,
        tSpace + kwQUERY + tSpace + expressionUntilSemiColon,
        expressionUntilSemiColon
    ]).set_results_name("body")
    stmtReturn <<= (
        stubNode.set_results_name("bodyStub") + kwRETURN + pp.Optional(return_expr, default=None) + SEMI
    ).set_parse_action(node(nodes.Return))

    # Raise Statement
    stmtRaise_level = (
        kwRAISE + tSpace +
        pp.MatchFirst([kwWARNING, kwNOTICE, kwINFO, kwLOG, kwDEBUG]).set_results_name("level") +
        pp.Optional(tSpace + expressionUntilSemiColon).set_results_name("expr") + SEMI
    ).set_parse_action(node(nodes.Raise))
    stmtRaise_exception = (
        stubNode.set_results_name("bodyStub") +
        kwRAISE + pp.Optional(tSpace + kwEXCEPTION + pp.Optional(tSpace)) +
        expressionUntilSemiColon.set_results_name("expr") + SEMI
    ).set_parse_action(node(nodes.Throw))
    stmtRaise <<= stmtRaise_level | stmtRaise_exception

    # Case Statement
    stmtCase_simple = (
        kwCASE + tSpace + pp.OneOrMore(pp.Optional(tSpace) + condWhen.set_results_name("cases")) +
        pp.Optional(pp.Optional(tSpace) + stmtElse.set_results_name("else")) +
        pp.Optional(tSpace) + kwEND + tSpace + kwCASE + pp.Optional(tSpace) + SEMI
    ).set_parse_action(node(nodes.Cond))
    stmtCase_expr = (
        kwCASE + tSpace + expressionUntilWhen.set_results_name("expr") +
        pp.OneOrMore(pp.Optional(tSpace) + caseWhen.set_results_name("cases")) +
        pp.Optional(pp.Optional(tSpace) + stmtElse.set_results_name("else")) +
        kwEND + tSpace + kwCASE + pp.Optional(tSpace) + SEMI
    ).set_parse_action(node(nodes.Case))
    stmtCase <<= stmtCase_simple | stmtCase_expr

    # If/Else Statements
    stmtElse_final = (
        kwELSE + tSpace + stubNode.set_results_name("bodyStub") + pp.ZeroOrMore(statement).set_results_name("body")
    ).set_parse_action(node(nodes.Else))
    stmtElsif = (
        kwELSIF + pp.Optional(tSpace) + stubNode.set_results_name("condStub") + expressionUntilThen.set_results_name("cond") +
        tSpace + kwTHEN + tSpace + stubNode.set_results_name("bodyStub") + pp.ZeroOrMore(statement).set_results_name("body") +
        pp.Optional(stmtElse.set_results_name("else"))
    ).set_parse_action(node(nodes.If))
    stmtElse <<= stmtElsif | stmtElse_final

    stmtIf <<= (
        kwIF + pp.Optional(tSpace) + stubNode.set_results_name("condStub") + expressionUntilThen.set_results_name("cond") +
        pp.Suppress(pp.Optional(tSpace) + kwTHEN) +
        tSpace + stubNode.set_results_name("bodyStub") + pp.ZeroOrMore(statement).set_results_name("body") +
        pp.Optional(pp.Optional(tSpace) + stmtElse.set_results_name("else")) +
        pp.Optional(tSpace) + kwEND + tSpace + kwIF + pp.Optional(tSpace) + SEMI
    ).set_parse_action(node(nodes.If))

    # Loop Statements
    stmtForSql <<= (sqlKeyword + tSpace + expressionUntilLoop.set_results_name("expr")).set_parse_action(node(nodes.Sql))
    
    stmtWhileLoop_labeled = (
        tLabelDefinition.set_results_name("label_open") + tSpace + kwWHILE + pp.Optional(tSpace) + stubNode.set_results_name("condStub") + expressionUntilLoop.set_results_name("cond") +
        tSpace + kwLOOP + tSpace + stubNode.set_results_name("bodyStub") + pp.ZeroOrMore(statement).set_results_name("body") +
        kwEND + tSpace + kwLOOP + pp.Optional(tSpace + tLabel.set_results_name("label_close")) + pp.Optional(tSpace) + SEMI
    ).set_parse_action(node(nodes.WhileLoop))
    stmtWhileLoop_unlabeled = (
        kwWHILE + pp.Optional(tSpace) + stubNode.set_results_name("condStub") + expressionUntilLoop.set_results_name("cond") +
        tSpace + kwLOOP + tSpace + stubNode.set_results_name("bodyStub") + pp.ZeroOrMore(statement).set_results_name("body") +
        kwEND + tSpace + kwLOOP + pp.Optional(tSpace) + SEMI
    ).set_parse_action(node(nodes.WhileLoop))
    stmtWhileLoop <<= stmtWhileLoop_labeled | stmtWhileLoop_unlabeled

    stmtLoop_labeled = (
        tLabelDefinition.set_results_name("label_open") + tSpace + kwLOOP + tSpace + stubNode.set_results_name("bodyStub") +
        pp.ZeroOrMore(pp.Optional(tSpace) + statement).set_results_name("body") +
        stubNode.set_results_name("doneStub") + kwEND + tSpace + kwLOOP +
        pp.Optional(tSpace + tLabel.set_results_name("label_close")) + pp.Optional(tSpace) + SEMI + stubNode.set_results_name("exitStub")
    ).set_parse_action(node(nodes.Loop))
    stmtLoop_unlabeled = (
        kwLOOP + tSpace + stubNode.set_results_name("bodyStub") +
        pp.ZeroOrMore(pp.Optional(tSpace) + statement).set_results_name("body") +
        stubNode.set_results_name("doneStub") + kwEND + tSpace + kwLOOP +
        pp.Optional(tSpace) + SEMI + stubNode.set_results_name("exitStub")
    ).set_parse_action(node(nodes.Loop))
    stmtLoop <<= stmtLoop_labeled | stmtLoop_unlabeled
    
    stmtForLoop_labeled = (
        tLabelDefinition.set_results_name("label_open") + tSpace + kwFOR + tSpace + identifierList.set_results_name("identifierList") + tSpace + kwIN + tSpace +
        (stmtForSql.set_results_name("cond") | expressionUntilLoop.set_results_name("cond")) +
        tSpace + kwLOOP + tSpace + stubNode.set_results_name("bodyStub") + pp.ZeroOrMore(statement).set_results_name("body") + stubNode.set_results_name("doneStub") +
        kwEND + tSpace + kwLOOP + pp.Optional(tSpace + tLabel.set_results_name("label_close")) + pp.Optional(tSpace) + SEMI + stubNode.set_results_name("exitStub")
    ).set_parse_action(node(nodes.ForLoop))
    stmtForLoop_unlabeled = (
        kwFOR + tSpace + identifierList.set_results_name("identifierList") + tSpace + kwIN + tSpace +
        (stmtForSql.set_results_name("cond") | expressionUntilLoop.set_results_name("cond")) +
        tSpace + kwLOOP + tSpace + stubNode.set_results_name("bodyStub") + pp.ZeroOrMore(statement).set_results_name("body") + stubNode.set_results_name("doneStub") +
        kwEND + tSpace + kwLOOP + pp.Optional(tSpace) + SEMI + stubNode.set_results_name("exitStub")
    ).set_parse_action(node(nodes.ForLoop))
    stmtForLoop <<= stmtForLoop_labeled | stmtForLoop_unlabeled

    stmtForEachLoop_labeled = (
        tLabelDefinition.set_results_name("label_open") + tSpace + kwFOREACH + tSpace + tIdentifier.set_results_name("tIdentifier") + tSpace +
        kwIN + tSpace + kwARRAY + tSpace + expressionUntilLoop.set_results_name("cond") +
        tSpace + kwLOOP + tSpace + stubNode.set_results_name("bodyStub") + pp.ZeroOrMore(statement).set_results_name("body") + stubNode.set_results_name("doneStub") +
        kwEND + tSpace + kwLOOP + pp.Optional(tSpace + tLabel.set_results_name("label_close")) + pp.Optional(tSpace) + SEMI + stubNode.set_results_name("exitStub")
    ).set_parse_action(node(nodes.ForEachLoop))
    stmtForEachLoop_unlabeled = (
        kwFOREACH + tSpace + tIdentifier.set_results_name("tIdentifier") + tSpace +
        kwIN + tSpace + kwARRAY + tSpace + expressionUntilLoop.set_results_name("cond") +
        tSpace + kwLOOP + tSpace + stubNode.set_results_name("bodyStub") + pp.ZeroOrMore(statement).set_results_name("body") + stubNode.set_results_name("doneStub") +
        kwEND + tSpace + kwLOOP + pp.Optional(tSpace) + SEMI + stubNode.set_results_name("exitStub")
    ).set_parse_action(node(nodes.ForEachLoop))
    stmtForEachLoop <<= stmtForEachLoop_labeled | stmtForEachLoop_unlabeled

    # --- 6. Top-Level Rules ---

    innerStatement <<= pp.MatchFirst([
        block + SEMI,
        stmtAssignment,
        stmtIf,
        stmtCase,
        stmtLoop,
        stmtWhileLoop,
        stmtForLoop,
        stmtForEachLoop,
        stmtExit,
        stmtContinue,
        stmtReturn,
        stmtRaise,
        stmtExecSql,
        stmtNull,
        stmtGetDiag
    ])
    
    statement <<= pp.Optional(tSpace) + innerStatement.set_results_name("inner") + pp.Optional(tSpace)
    statement.set_parse_action(node(nodes.Statement))

    block_with_label <<= (
        tLabelDefinition.set_results_name("label_open") + tSpace + pp.ZeroOrMore(stmtDeclare).set_results_name("blockDeclarations") +
        kwBEGIN + tSpace +
        stubNode.set_results_name("bodyStub") +
        pp.ZeroOrMore(statement).set_results_name("body") +
        pp.Optional(blockExceptions).set_results_name("blockExceptions") +
        kwEND +
        pp.Optional(tSpace + tLabel).set_results_name("label_close") +
        pp.Optional(tSpace)
    )

    block_without_label <<= (
        pp.ZeroOrMore(stmtDeclare).set_results_name("blockDeclarations") +
        kwBEGIN + tSpace +
        stubNode.set_results_name("bodyStub") +
        pp.ZeroOrMore(statement).set_results_name("body") +
        pp.Optional(blockExceptions).set_results_name("blockExceptions") +
        kwEND +
        pp.Optional(tSpace)
    )
    
    block <<= block_with_label | block_without_label
    block.set_parse_action(node(nodes.Block))

    block.ignore(tComment)

    # --- 7. Finalize and Return ---
    tEOF <<= pp.StringEnd().set_parse_action(node(nodes.Terminal)) 
    start <<= pp.Optional(tSpace) + block + pp.Optional(SEMI) + pp.Optional(tSpace) + tEOF

    # The original file's Rule Naming and Debugging (Optional but helpful)
    start.set_name("start")
    block.set_name("block")
    # ... (other set_name calls as in the original file) ...
    stmtIf.setDebug(False) 

    # Return the top-level rule
    return start