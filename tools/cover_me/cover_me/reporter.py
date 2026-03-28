"""
Generate OpenCover XML from coverage profile.

OpenCover mapping:
    Module          → Schema
    Class           → Schema.FunctionName
    Method          → The function itself
    SequencePoint   → Each instrumented block/branch point (visit count)
    BranchPoint     → Each conditional tag (IF/ELSIF/WHILE)
"""
from pathlib import Path
from xml.etree.ElementTree import Element, SubElement, ElementTree, indent

from cover_me.instrumenter import Tag, TagType
from cover_me.profile import Profile, TagProfile
from cover_me.models import ProcedureDef


def _group_by_schema(procedures: list[ProcedureDef]) -> dict[str, list[ProcedureDef]]:
    groups: dict[str, list[ProcedureDef]] = {}
    for proc in procedures:
        groups.setdefault(proc.schema, []).append(proc)
    return groups


def generate_opencover(
    procedures: list[ProcedureDef],
    tags_by_oid: dict[str, list[Tag]],
    profile: Profile,
    output_path: Path,
    source_dir: Path | None = None,
) -> None:
    """Generate OpenCover XML report."""
    root = Element("CoverageSession")

    modules_el = SubElement(root, "Modules")

    file_id_map: dict[str, str] = {}
    file_counter = 1

    for schema, procs in sorted(_group_by_schema(procedures).items()):
        module_el = SubElement(modules_el, "Module")
        module_el.set("hash", schema)

        mod_name = SubElement(module_el, "ModuleName")
        mod_name.text = schema

        files_el = SubElement(module_el, "Files")
        classes_el = SubElement(module_el, "Classes")

        for proc in sorted(procs, key=lambda p: p.name):
            # File entry
            file_key = proc.qualified_name
            if file_key not in file_id_map:
                file_id_map[file_key] = str(file_counter)
                file_counter += 1
            fid = file_id_map[file_key]

            file_el = SubElement(files_el, "File")
            file_el.set("uid", fid)
            if source_dir:
                file_el.set("fullPath", str(source_dir / proc.schema / f"{proc.name}.sql"))
            else:
                file_el.set("fullPath", f"{proc.schema}/{proc.name}.sql")

            # Class
            class_el = SubElement(classes_el, "Class")
            class_name_el = SubElement(class_el, "FullName")
            class_name_el.text = proc.qualified_name

            methods_el = SubElement(class_el, "Methods")
            method_el = SubElement(methods_el, "Method")

            method_name_el = SubElement(method_el, "Name")
            method_name_el.text = proc.signature

            # Gather tags for this procedure
            proc_tags = tags_by_oid.get(proc.oid, [])
            if not proc_tags:
                continue

            # Summary
            seq_tags = [t for t in proc_tags if t.tag_type in (TagType.BLOCK, TagType.BRANCH, TagType.LOOP)]
            branch_tags = [t for t in proc_tags if t.tag_type == TagType.BRANCH]

            visited_seq = sum(1 for t in seq_tags if profile.get(t.id) and profile.get(t.id).visit_count > 0)
            visited_branch = sum(1 for t in branch_tags if profile.get(t.id) and profile.get(t.id).visit_count > 0)

            summary_el = SubElement(method_el, "Summary")
            summary_el.set("numSequencePoints", str(len(seq_tags)))
            summary_el.set("visitedSequencePoints", str(visited_seq))
            summary_el.set("numBranchPoints", str(len(branch_tags)))
            summary_el.set("visitedBranchPoints", str(visited_branch))

            if seq_tags:
                summary_el.set("sequenceCoverage", f"{visited_seq / len(seq_tags) * 100:.2f}")
            else:
                summary_el.set("sequenceCoverage", "0")

            if branch_tags:
                summary_el.set("branchCoverage", f"{visited_branch / len(branch_tags) * 100:.2f}")
            else:
                summary_el.set("branchCoverage", "0")

            # Sequence points
            sp_el = SubElement(method_el, "SequencePoints")
            for ordinal, tag in enumerate(seq_tags):
                tp = profile.get(tag.id)
                vc = tp.visit_count if tp else 0
                sp = SubElement(sp_el, "SequencePoint")
                sp.set("vc", str(vc))
                sp.set("sl", str(tag.line))
                sp.set("sc", "1")
                sp.set("el", str(tag.line))
                sp.set("ec", "1")
                sp.set("fileid", fid)
                sp.set("ordinal", str(ordinal))

            # Branch points
            bp_el = SubElement(method_el, "BranchPoints")
            for ordinal, tag in enumerate(branch_tags):
                tp = profile.get(tag.id)
                vc = tp.visit_count if tp else 0
                bp = SubElement(bp_el, "BranchPoint")
                bp.set("vc", str(vc))
                bp.set("sl", str(tag.line))
                bp.set("path", "0" if tp and tp.true_count > 0 else "1")
                bp.set("ordinal", str(ordinal))
                bp.set("fileid", fid)

    # Module-level summary
    for module_el in modules_el:
        _add_module_summary(module_el)

    indent(root, space="  ")
    tree = ElementTree(root)
    output_path.parent.mkdir(parents=True, exist_ok=True)
    tree.write(str(output_path), xml_declaration=True, encoding="utf-8")


def _add_module_summary(module_el: Element) -> None:
    """Add a Summary element to a Module by aggregating its methods."""
    total_seq = 0
    visited_seq = 0
    total_branch = 0
    visited_branch = 0

    for summary in module_el.iter("Summary"):
        total_seq += int(summary.get("numSequencePoints", "0"))
        visited_seq += int(summary.get("visitedSequencePoints", "0"))
        total_branch += int(summary.get("numBranchPoints", "0"))
        visited_branch += int(summary.get("visitedBranchPoints", "0"))

    summary_el = Element("Summary")
    summary_el.set("numSequencePoints", str(total_seq))
    summary_el.set("visitedSequencePoints", str(visited_seq))
    summary_el.set("numBranchPoints", str(total_branch))
    summary_el.set("visitedBranchPoints", str(visited_branch))
    summary_el.set("sequenceCoverage", f"{visited_seq / total_seq * 100:.2f}" if total_seq else "0")
    summary_el.set("branchCoverage", f"{visited_branch / total_branch * 100:.2f}" if total_branch else "0")

    module_el.insert(0, summary_el)
