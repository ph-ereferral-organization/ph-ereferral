#!/usr/bin/env python3
"""Generate a markdown table from the TDG FHIR Mapping CSV for the IG data dictionary.

Run this script from anywhere; it resolves paths relative to its own location.

Usage:
    python input/generate_data_dictionary_table.py
    python input/generate_data_dictionary_table.py --csv "TDG FHIR Mapping v2.csv"
"""

import argparse
import csv
import html
import re
import sys
from pathlib import Path

SCRIPT_DIR = Path(__file__).resolve().parent
REPO_ROOT = SCRIPT_DIR.parent
OUTPUT_FILE = SCRIPT_DIR / "includes" / "data-dictionary-table.md"


def escape_cell(text: str) -> str:
    """Escape a cell value for markdown table display.

    Multi-line cells have newlines replaced with <br> for HTML rendering
    inside Jekyll markdown tables. Pipe characters are escaped.
    """
    if not text:
        return ""
    text = text.replace("\r\n", "\n").replace("\r", "\n")
    text = html.escape(text)
    text = text.replace("\n", "<br>")
    text = text.replace("|", "&#124;")
    return text


def read_csv(csv_path: Path) -> list[list[str]]:
    """Read the CSV and return rows, stripping trailing empty columns."""
    if not csv_path.exists():
        print(f"Error: {csv_path} not found.", file=sys.stderr)
        sys.exit(1)

    with open(csv_path, "r", encoding="utf-8", newline="") as f:
        reader = csv.reader(f)
        rows = [row for row in reader]

    return rows


def is_header_row(row: list[str]) -> bool:
    """The real header row has 'Workflow Task' in the first column."""
    return len(row) > 0 and row[0].strip() == "Workflow Task"


def is_note_row(row: list[str]) -> bool:
    """Skip rows whose Element ID starts with 'NOTE' or is empty (sub-header)."""
    if len(row) < 2:
        return True
    eid = row[1].strip() if len(row) > 1 else ""
    return eid == "" or eid.startswith("NOTE")


def generate_table(rows: list[list[str]]) -> str:
    """Convert CSV rows to a markdown table with {:.ph-table} IAL."""
    if not rows:
        return "No data found."

    # Find the header row
    header_idx = None
    for i, row in enumerate(rows):
        if is_header_row(row):
            header_idx = i
            break

    if header_idx is None:
        print("Error: Could not find header row in CSV.", file=sys.stderr)
        sys.exit(1)

    headers = rows[header_idx]
    data_rows = [row for row in rows[header_idx + 1:] if not is_note_row(row)]

    if not data_rows:
        return "No data rows found."

    lines = []

    # Header
    lines.append("| " + " | ".join(escape_cell(h) for h in headers) + " |")

    # Separator
    lines.append("|" + "|".join(" --- " for _ in headers) + "|")

    # Data rows
    for row in data_rows:
        cells = row[:len(headers)]
        while len(cells) < len(headers):
            cells.append("")
        escaped = [escape_cell(c) for c in cells]
        lines.append("| " + " | ".join(escaped) + " |")

    lines.append("{:.ph-table}")

    return "\n".join(lines)


def main():
    parser = argparse.ArgumentParser(
        description="Generate markdown data dictionary table from TDG FHIR Mapping CSV."
    )
    parser.add_argument(
        "--csv",
        default="TDG FHIR Mapping.csv",
        help="CSV filename relative to repo root (default: 'TDG FHIR Mapping.csv')",
    )
    args = parser.parse_args()

    csv_path = REPO_ROOT / args.csv
    rows = read_csv(csv_path)
    content = generate_table(rows)

    OUTPUT_FILE.parent.mkdir(parents=True, exist_ok=True)
    with open(OUTPUT_FILE, "w", encoding="utf-8") as f:
        f.write(content.strip() + "\n")

    print(f"Generated {OUTPUT_FILE} ({len(content)} bytes) from {csv_path.name}")


if __name__ == "__main__":
    main()
