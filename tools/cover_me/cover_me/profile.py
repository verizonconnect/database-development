"""
Parse RAISE WARNING trace output and build coverage profile.

Reads lines like:
    WARNING:  COVER_ME 0123456789abcdef
    WARNING:  COVER_ME 0123456789abcdef t
    WARNING:  COVER_ME 0123456789abcdef f
"""
import re
from dataclasses import dataclass, field
from pathlib import Path

from cover_me.instrumenter import Tag, TagType


# Matches: WARNING:  COVER_ME <16-hex-id> [t|f]
_PATTERN = re.compile(r'WARNING:\s+COVER_ME\s+([0-9a-f]{16})(?:\s+([tf]))?')


@dataclass
class TagProfile:
    """Coverage state for a single tag."""
    tag: Tag
    visit_count: int = 0
    true_count: int = 0
    false_count: int = 0

    def ping(self, value: str | None = None) -> None:
        self.visit_count += 1
        if value == "t":
            self.true_count += 1
        elif value == "f":
            self.false_count += 1


@dataclass
class Profile:
    """Aggregated coverage profile across all functions."""
    _tags: dict[str, TagProfile] = field(default_factory=dict)

    def register(self, tags: list[Tag]) -> None:
        """Register tags from an instrumented function."""
        for tag in tags:
            if tag.id not in self._tags:
                self._tags[tag.id] = TagProfile(tag=tag)

    def ping(self, tag_id: str, value: str | None = None) -> None:
        """Record a coverage hit."""
        if tag_id in self._tags:
            self._tags[tag_id].ping(value)

    def get(self, tag_id: str) -> TagProfile | None:
        return self._tags.get(tag_id)

    @property
    def all_tags(self) -> list[TagProfile]:
        return list(self._tags.values())

    def tags_for_oid(self, oid: str) -> list[TagProfile]:
        """Get all tag profiles whose tag_id was generated for a given OID."""
        # Tags don't store OID directly, so we rely on the caller grouping them
        return self.all_tags

    def parse_file(self, path: Path) -> int:
        """Parse a trace file and record coverage hits. Returns hit count."""
        hits = 0
        with open(path, "r") as f:
            for line in f:
                m = _PATTERN.search(line)
                if m:
                    self.ping(m.group(1), m.group(2))
                    hits += 1
        return hits

    def parse_lines(self, lines: list[str]) -> int:
        """Parse lines and record coverage hits. Returns hit count."""
        hits = 0
        for line in lines:
            m = _PATTERN.search(line)
            if m:
                self.ping(m.group(1), m.group(2))
                hits += 1
        return hits
