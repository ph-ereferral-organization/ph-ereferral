#!/usr/bin/env python3
"""Generate a styled HTML table from data-dictionary.csv for the IG.

Run this script from anywhere; it resolves paths relative to its own location.
"""

import csv
import html
import sys
from pathlib import Path

# Resolve paths relative to this script (inside input/)
INPUT_DIR = Path(__file__).resolve().parent
CSV_FILE = INPUT_DIR / "images" / "data-dictionary.csv"
OUTPUT_FILE = INPUT_DIR / "includes" / "data-dictionary-table.html"


def escape_html(text: str) -> str:
    """Escape HTML entities and normalize whitespace."""
    if not text:
        return ""
    # Replace newlines with <br> for HTML display
    text = text.replace("\r\n", "\n").replace("\r", "\n")
    text = html.escape(text)
    text = text.replace("\n", "<br>")
    return text


def generate_table() -> str:
    """Read CSV and generate styled HTML table."""
    if not CSV_FILE.exists():
        print(f"Error: {CSV_FILE} not found.", file=sys.stderr)
        sys.exit(1)

    rows = []
    with open(CSV_FILE, "r", encoding="utf-8", newline="") as f:
        reader = csv.reader(f)
        for row in reader:
            rows.append(row)

    if not rows:
        return "<p>No data found.</p>"

    # Header row (row 0)
    headers = rows[0]
    # Skip the header description row (row 1, where Element ID is empty)
    data_rows = rows[2:]

    # Build HTML
    lines = [
        '<div class="table-responsive data-dictionary-wrapper">',
        '  <table class="table table-bordered table-striped table-condensed">',
        '    <thead class="thead-dark">',
        '      <tr>',
    ]
    for h in headers:
        lines.append(f"        <th>{escape_html(h)}</th>")
    lines.extend([
        '      </tr>',
        '    </thead>',
        '    <tbody>',
    ])

    for row in data_rows:
        # Ensure we have the same number of cells as headers
        cells = row[:len(headers)]
        while len(cells) < len(headers):
            cells.append("")

        lines.append('      <tr>')
        for cell in cells:
            cell_html = escape_html(cell)
            if not cell_html:
                cell_html = "&nbsp;"
            lines.append(f"        <td>{cell_html}</td>")
        lines.append('      </tr>')

    lines.extend([
        '    </tbody>',
        '  </table>',
        '</div>',
    ])

    return "\n".join(lines)


def main():
    # Ensure includes directory exists
    OUTPUT_FILE.parent.mkdir(parents=True, exist_ok=True)

    html_content = generate_table()
    with open(OUTPUT_FILE, "w", encoding="utf-8") as f:
        f.write(html_content)

    print(f"Generated {OUTPUT_FILE} ({len(html_content)} bytes)")


if __name__ == "__main__":
    main()
