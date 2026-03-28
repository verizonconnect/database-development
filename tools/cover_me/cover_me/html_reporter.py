"""
Generate HTML coverage report from OpenCover XML and source files.
"""
from pathlib import Path
from xml.etree.ElementTree import parse as parse_xml

CSS = """
body { font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif; margin: 20px; background: #f5f5f5; }
h1 { color: #333; }
table { border-collapse: collapse; width: 100%; background: white; box-shadow: 0 1px 3px rgba(0,0,0,0.1); }
th, td { padding: 8px 12px; text-align: left; border-bottom: 1px solid #eee; }
th { background: #2c3e50; color: white; }
tr:hover { background: #f0f7ff; }
.pct { text-align: right; width: 120px; }
.bar { height: 16px; border-radius: 3px; display: inline-block; }
.bar-green { background: #27ae60; }
.bar-red { background: #e74c3c; }
.bar-bg { background: #ecf0f1; width: 100px; display: inline-block; border-radius: 3px; overflow: hidden; }
a { color: #2980b9; text-decoration: none; }
a:hover { text-decoration: underline; }
.summary { background: white; padding: 15px; margin-bottom: 20px; border-radius: 4px; box-shadow: 0 1px 3px rgba(0,0,0,0.1); }
pre { background: white; padding: 0; margin: 0; }
.line { display: flex; }
.line-num { width: 50px; text-align: right; padding-right: 10px; color: #999; user-select: none; flex-shrink: 0; }
.line-code { flex: 1; white-space: pre; padding-left: 10px; }
.hit { background: #d4edda; }
.miss { background: #f8d7da; }
.neutral { background: white; }
"""


def _bar(pct: float) -> str:
    w = int(pct)
    color = "#27ae60" if pct >= 80 else "#f39c12" if pct >= 50 else "#e74c3c"
    return (f'<span class="bar-bg">'
            f'<span class="bar" style="width:{w}px;background:{color}"></span>'
            f'</span> {pct:.1f}%')


def generate_html(opencover_path: Path, output_dir: Path) -> None:
    """Generate HTML report from opencover.xml."""
    tree = parse_xml(str(opencover_path))
    root = tree.getroot()
    output_dir.mkdir(parents=True, exist_ok=True)

    # Build index
    rows = []
    for module in root.findall(".//Module"):
        mod_name = module.find("ModuleName").text
        summary = module.find("Summary")
        if summary is None:
            continue

        total_seq = int(summary.get("numSequencePoints", "0"))
        visited_seq = int(summary.get("visitedSequencePoints", "0"))
        seq_pct = float(summary.get("sequenceCoverage", "0"))

        for cls in module.findall(".//Class"):
            full_name = cls.find("FullName").text
            for method in cls.findall(".//Method"):
                m_summary = method.find("Summary")
                if m_summary is None:
                    continue
                m_seq = int(m_summary.get("numSequencePoints", "0"))
                m_vis = int(m_summary.get("visitedSequencePoints", "0"))
                m_pct = float(m_summary.get("sequenceCoverage", "0"))
                m_branch = int(m_summary.get("numBranchPoints", "0"))
                m_bvis = int(m_summary.get("visitedBranchPoints", "0"))
                b_pct = float(m_summary.get("branchCoverage", "0"))

                # Find source file
                sp = method.findall(".//SequencePoint")
                file_id = sp[0].get("fileid") if sp else None
                source_path = None
                if file_id:
                    for f in module.findall(".//File"):
                        if f.get("uid") == file_id:
                            source_path = f.get("fullPath")
                            break

                # Collect visited lines
                visited_lines = {}
                for s in sp:
                    line = int(s.get("sl", "0"))
                    vc = int(s.get("vc", "0"))
                    visited_lines[line] = max(visited_lines.get(line, 0), vc)

                # Generate per-function page
                func_filename = full_name.replace(".", "_") + ".html"
                _generate_function_page(
                    output_dir / func_filename, full_name,
                    source_path, visited_lines, m_pct, b_pct
                )

                rows.append((full_name, m_seq, m_vis, m_pct, m_branch, m_bvis, b_pct, func_filename))

    _generate_index(output_dir / "index.html", rows)
    print(f"HTML report generated at {output_dir / 'index.html'}")


def _generate_index(path: Path, rows: list) -> None:
    total_seq = sum(r[1] for r in rows)
    visited_seq = sum(r[2] for r in rows)
    overall_pct = (visited_seq / total_seq * 100) if total_seq else 0

    html = f"""<!DOCTYPE html>
<html><head><meta charset="utf-8"><title>Coverage Report</title>
<style>{CSS}</style></head><body>
<h1>Code Coverage</h1>
<div class="summary">
  <strong>Overall:</strong> {visited_seq}/{total_seq} sequence points covered — {_bar(overall_pct)}
</div>
<table>
<tr><th>Function</th><th class="pct">Seq Points</th><th class="pct">Seq Coverage</th><th class="pct">Branch Points</th><th class="pct">Branch Coverage</th></tr>
"""
    for name, seq, vis, pct, branch, bvis, bpct, filename in sorted(rows):
        html += f'<tr><td><a href="{filename}">{name}</a></td>'
        html += f'<td class="pct">{vis}/{seq}</td><td class="pct">{_bar(pct)}</td>'
        html += f'<td class="pct">{bvis}/{branch}</td><td class="pct">{_bar(bpct)}</td></tr>\n'

    html += "</table></body></html>"
    path.write_text(html)


def _generate_function_page(
    path: Path, name: str, source_path: str | None,
    visited_lines: dict[int, int], seq_pct: float, branch_pct: float
) -> None:
    source_lines = []
    if source_path and Path(source_path).exists():
        source_lines = Path(source_path).read_text().splitlines()

    html = f"""<!DOCTYPE html>
<html><head><meta charset="utf-8"><title>{name}</title>
<style>{CSS}</style></head><body>
<h1>{name}</h1>
<div class="summary">
  Sequence: {_bar(seq_pct)} &nbsp; Branch: {_bar(branch_pct)}
  &nbsp; <a href="index.html">← Back</a>
</div>
<pre>"""

    for i, line in enumerate(source_lines, 1):
        vc = visited_lines.get(i)
        if vc is not None and vc > 0:
            cls = "hit"
        elif vc is not None:
            cls = "miss"
        else:
            cls = "neutral"
        escaped = line.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;")
        html += f'<div class="line {cls}"><span class="line-num">{i}</span><span class="line-code">{escaped}</span></div>\n'

    html += "</pre></body></html>"
    path.write_text(html)
