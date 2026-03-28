"""
Tests for the profile and reporter modules.
"""
import pytest
from pathlib import Path
from xml.etree.ElementTree import parse as parse_xml

from cover_me.instrumenter import Tag, TagType, instrument
from cover_me.profile import Profile, TagProfile, _PATTERN
from cover_me.reporter import generate_opencover
from cover_me.models import ProcedureDef


# ---------------------------------------------------------------------------
# Pattern matching tests
# ---------------------------------------------------------------------------

class TestPattern:

    def test_matches_branch_hit(self):
        m = _PATTERN.search("WARNING:  COVER_ME 0123456789abcdef")
        assert m is not None
        assert m.group(1) == "0123456789abcdef"
        assert m.group(2) is None

    def test_matches_cond_true(self):
        m = _PATTERN.search("WARNING:  COVER_ME abcdef0123456789 t")
        assert m is not None
        assert m.group(1) == "abcdef0123456789"
        assert m.group(2) == "t"

    def test_matches_cond_false(self):
        m = _PATTERN.search("WARNING:  COVER_ME abcdef0123456789 f")
        assert m.group(2) == "f"

    def test_no_match_on_noise(self):
        assert _PATTERN.search("some random log line") is None

    def test_matches_in_pg_prove_output(self):
        line = 'psql:test.sql:5: WARNING:  COVER_ME 0123456789abcdef t'
        m = _PATTERN.search(line)
        assert m is not None
        assert m.group(1) == "0123456789abcdef"


# ---------------------------------------------------------------------------
# TagProfile tests
# ---------------------------------------------------------------------------

class TestTagProfile:

    def test_ping_branch(self):
        tag = Tag(id="aaa", tag_type=TagType.BLOCK, line=1, description="block")
        tp = TagProfile(tag=tag)
        tp.ping(None)
        tp.ping(None)
        assert tp.visit_count == 2
        assert tp.true_count == 0
        assert tp.false_count == 0

    def test_ping_cond_true_false(self):
        tag = Tag(id="bbb", tag_type=TagType.BRANCH, line=2, description="IF")
        tp = TagProfile(tag=tag)
        tp.ping("t")
        tp.ping("f")
        tp.ping("t")
        assert tp.visit_count == 3
        assert tp.true_count == 2
        assert tp.false_count == 1


# ---------------------------------------------------------------------------
# Profile tests
# ---------------------------------------------------------------------------

class TestProfile:

    def test_register_and_ping(self):
        tags = [
            Tag(id="aaa1234567890000", tag_type=TagType.BLOCK, line=1, description="block"),
            Tag(id="bbb1234567890000", tag_type=TagType.BRANCH, line=2, description="IF"),
        ]
        profile = Profile()
        profile.register(tags)
        profile.ping("aaa1234567890000")
        profile.ping("bbb1234567890000", "t")

        assert profile.get("aaa1234567890000").visit_count == 1
        assert profile.get("bbb1234567890000").true_count == 1

    def test_ping_unknown_tag_ignored(self):
        profile = Profile()
        profile.ping("unknown_tag_id_00")  # should not raise

    def test_parse_lines(self):
        tags = [
            Tag(id="aaa1234567890000", tag_type=TagType.BLOCK, line=1, description="block"),
            Tag(id="bbb1234567890000", tag_type=TagType.BRANCH, line=2, description="IF"),
        ]
        profile = Profile()
        profile.register(tags)

        lines = [
            "WARNING:  COVER_ME aaa1234567890000",
            "WARNING:  COVER_ME bbb1234567890000 t",
            "WARNING:  COVER_ME bbb1234567890000 f",
            "some other output",
            "WARNING:  COVER_ME aaa1234567890000",
        ]
        hits = profile.parse_lines(lines)
        assert hits == 4
        assert profile.get("aaa1234567890000").visit_count == 2
        assert profile.get("bbb1234567890000").visit_count == 2
        assert profile.get("bbb1234567890000").true_count == 1
        assert profile.get("bbb1234567890000").false_count == 1

    def test_parse_file(self, tmp_path):
        tags = [
            Tag(id="aaa1234567890000", tag_type=TagType.BLOCK, line=1, description="block"),
        ]
        profile = Profile()
        profile.register(tags)

        trace_file = tmp_path / "trace.txt"
        trace_file.write_text(
            "WARNING:  COVER_ME aaa1234567890000\n"
            "WARNING:  COVER_ME aaa1234567890000\n"
            "noise\n"
        )
        hits = profile.parse_file(trace_file)
        assert hits == 2
        assert profile.get("aaa1234567890000").visit_count == 2


# ---------------------------------------------------------------------------
# Reporter tests
# ---------------------------------------------------------------------------

class TestReporter:

    def _make_proc(self, oid="1", schema="public", name="test_func"):
        return ProcedureDef(
            oid=oid, schema=schema, name=name,
            source="BEGIN\n  IF x > 0 THEN\n    y := 1;\n  END IF;\n  RETURN y;\nEND;",
            is_strict=False, is_secdef=False, is_setof=False,
            return_type="integer", volatility="VOLATILE",
            arg_modes=["IN"], arg_names=["x"], arg_types=["integer"],
        )

    def test_generates_valid_xml(self, tmp_path):
        proc = self._make_proc()
        result = instrument(proc.source, proc.oid)

        profile = Profile()
        profile.register(result.tags)
        # Simulate some hits
        for tag in result.tags:
            profile.ping(tag.id, "t")

        output = tmp_path / "opencover.xml"
        generate_opencover([proc], {proc.oid: result.tags}, profile, output)

        assert output.exists()
        tree = parse_xml(str(output))
        root = tree.getroot()
        assert root.tag == "CoverageSession"

    def test_module_per_schema(self, tmp_path):
        proc1 = self._make_proc(oid="1", schema="hr", name="func_a")
        proc2 = self._make_proc(oid="2", schema="sales", name="func_b")

        tags_by_oid = {}
        profile = Profile()
        for proc in [proc1, proc2]:
            result = instrument(proc.source, proc.oid)
            tags_by_oid[proc.oid] = result.tags
            profile.register(result.tags)

        output = tmp_path / "opencover.xml"
        generate_opencover([proc1, proc2], tags_by_oid, profile, output)

        tree = parse_xml(str(output))
        modules = tree.findall(".//Module")
        schema_names = {m.find("ModuleName").text for m in modules}
        assert schema_names == {"hr", "sales"}

    def test_sequence_and_branch_points(self, tmp_path):
        proc = self._make_proc()
        result = instrument(proc.source, proc.oid)

        profile = Profile()
        profile.register(result.tags)
        # Hit the IF condition as true
        for tag in result.tags:
            if tag.tag_type == TagType.BRANCH:
                profile.ping(tag.id, "t")

        output = tmp_path / "opencover.xml"
        generate_opencover([proc], {proc.oid: result.tags}, profile, output)

        tree = parse_xml(str(output))
        seq_points = tree.findall(".//SequencePoint")
        branch_points = tree.findall(".//BranchPoint")
        assert len(seq_points) > 0
        assert len(branch_points) > 0

        # At least one visited
        visited = [sp for sp in seq_points if int(sp.get("vc", "0")) > 0]
        assert len(visited) > 0

    def test_summary_coverage_percentages(self, tmp_path):
        proc = self._make_proc()
        result = instrument(proc.source, proc.oid)

        profile = Profile()
        profile.register(result.tags)
        # Hit all tags
        for tag in result.tags:
            profile.ping(tag.id, "t")
            profile.ping(tag.id, "f")

        output = tmp_path / "opencover.xml"
        generate_opencover([proc], {proc.oid: result.tags}, profile, output)

        tree = parse_xml(str(output))
        summary = tree.find(".//Method/Summary")
        assert summary is not None
        assert float(summary.get("sequenceCoverage")) > 0

    def test_zero_coverage(self, tmp_path):
        proc = self._make_proc()
        result = instrument(proc.source, proc.oid)

        profile = Profile()
        profile.register(result.tags)
        # No hits

        output = tmp_path / "opencover.xml"
        generate_opencover([proc], {proc.oid: result.tags}, profile, output)

        tree = parse_xml(str(output))
        summary = tree.find(".//Method/Summary")
        assert summary.get("visitedSequencePoints") == "0"
        assert summary.get("visitedBranchPoints") == "0"
