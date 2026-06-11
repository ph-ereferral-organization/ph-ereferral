#!/usr/bin/env python3
"""Generate reference PNG page images and references.md from YAML metadata.

Dependencies:
    pdftoppm (from poppler-utils / poppler package)

Run this script from anywhere; it resolves paths relative to its own location.
"""

import re
import shutil
import subprocess
import sys
from pathlib import Path

import yaml

# Resolve paths relative to this script (inside input/)
INPUT_DIR = Path(__file__).resolve().parent
YAML_FILE = INPUT_DIR / "references.yaml"
PDF_DIR = INPUT_DIR / "images" / "references"
PNG_DIR = INPUT_DIR / "images" / "references-pages"
OUTPUT_MD = INPUT_DIR / "pagecontent" / "references.md"


def check_pdftoppm() -> bool:
    """Return True if pdftoppm is available on PATH."""
    return shutil.which("pdftoppm") is not None


def get_page_count(pdf_path: Path) -> int:
    """Count pages in a PDF using pdfinfo (from poppler)."""
    try:
        result = subprocess.run(
            ["pdfinfo", str(pdf_path)],
            capture_output=True,
            text=True,
            check=True,
        )
        for line in result.stdout.splitlines():
            if line.startswith("Pages:"):
                return int(line.split(":", 1)[1].strip())
    except Exception:
        pass
    # Fallback: count generated PNGs after conversion
    return 0


def convert_pdf_to_pngs(pdf_path: Path, output_prefix: Path) -> int:
    """Convert a PDF to PNG page images using pdftoppm.

    Returns the number of pages generated.
    """
    # pdftoppm outputs: prefix-01.png, prefix-02.png, ...
    # We want: prefix-page-01.png, prefix-page-02.png, ...
    # So use a temp prefix and rename
    temp_prefix = output_prefix.parent / f"_tmp_{output_prefix.name}"
    subprocess.run(
        [
            "pdftoppm",
            "-png",
            str(pdf_path),
            str(temp_prefix),
        ],
        check=True,
    )

    # Rename temp files to final names
    page_count = 0
    temp_files = sorted(temp_prefix.parent.glob(f"{temp_prefix.name}-*.png"))
    for temp_file in temp_files:
        page_count += 1
        page_num = f"{page_count:02d}"
        final_file = output_prefix.parent / f"{output_prefix.name}-page-{page_num}.png"
        temp_file.rename(final_file)

    return page_count


def clean_orphaned_pngs(pdf_name: str, page_count: int) -> None:
    """Remove PNG page images for a PDF that no longer exist (e.g. page count reduced)."""
    prefix = pdf_name.replace(".pdf", "")
    existing = sorted(PNG_DIR.glob(f"{prefix}-page-*.png"))
    for png_file in existing:
        # Extract page number from filename
        match = re.search(rf"{re.escape(prefix)}-page-(\d+)\.png$", png_file.name)
        if match:
            page_num = int(match.group(1))
            if page_num > page_count:
                print(f"  Removing orphaned {png_file.name}")
                png_file.unlink()


def generate_references_md(references: list, folder_url: str) -> str:
    """Generate references.md from metadata and actual page counts."""
    lines = [
        "# References",
        "",
        "This page lists reference documents, standards, and policies that inform the development of the PH eReferral Implementation Guide.",
        "",
        "## PH eReferral L1 Basis: Department of Health",
        "",
    ]

    for ref in references:
        title = ref["title"]
        pdf = ref["pdf"]
        drive_url = ref["drive_url"]
        pdf_stem = pdf.replace(".pdf", "")

        lines.append(f"### {title}")
        lines.append("")
        lines.append(f"- [View on Google Drive]({drive_url})")
        lines.append("- Inline preview:")
        lines.append("")
        lines.append(f'  <object data="references/{pdf}" type="application/pdf" width="100%" height="500px">')
        lines.append(f'    <div')
        lines.append(f'      class="pdf-fallback"')
        lines.append(f'      style="max-height: 500px; overflow-y: auto; border: 1px solid #d0d0d0; padding: 0.75rem; background: #ffffff; box-shadow: inset 0 0 0 1px #f8f8f8;"')
        lines.append(f'      role="region"')
        lines.append(f'      aria-label="Image preview pages for {title} PDF"')
        lines.append(f"    >")
        lines.append(f"      <p>")
        lines.append(f"        Inline PDF preview unavailable. View the generated page images below, or")
        lines.append(f'        <a href="{drive_url}" target="_blank">open on Google Drive</a>.')
        lines.append(f"      </p>")

        # Find actual page images for this PDF
        png_files = sorted(PNG_DIR.glob(f"{pdf_stem}-page-*.png"))
        for i, png_file in enumerate(png_files):
            page_num = i + 1
            alt = f"{title}, page {page_num}"
            margin = "0 0 1rem;" if i < len(png_files) - 1 else "0;"
            lines.append(f'      <figure style="margin: {margin}">')
            lines.append(f'        <img src="references-pages/{png_file.name}" alt="{alt}" style="width: 100%; height: auto;" loading="lazy" />')
            lines.append(f"      </figure>")

        lines.append(f"    </div>")
        lines.append(f"  </object>")
        lines.append("")

    lines.extend([
        "---",
        "",
        "## Related FHIR Implementation Guides",
        "",
        "- [PH Core FHIR IG](https://github.com/UP-Manila-SILab/ph-core)",
        "- [PH eReferral IG](https://github.com/ph-ereferral-organization/ph-ereferral)",
        "",
        "## Technical Standards",
        "",
        "- [FHIR R4](http://hl7.org/fhir/R4/)",
        "- [FHIR Shorthand (FSH)](https://fshschool.org/)",
        "- [HL7 FHIR IG Publisher](https://github.com/HL7/fhir-ig-publisher)",
        "",
    ])

    return "\n".join(lines)


def main():
    if not check_pdftoppm():
        print(
            "Error: pdftoppm is not installed or not on PATH.\n"
            "Please install poppler-utils (Linux) or poppler (macOS/Homebrew).\n"
            "  macOS: brew install poppler\n"
            "  Ubuntu/Debian: sudo apt-get install poppler-utils",
            file=sys.stderr,
        )
        sys.exit(1)

    if not YAML_FILE.exists():
        print(f"Error: {YAML_FILE} not found.", file=sys.stderr)
        sys.exit(1)

    with open(YAML_FILE, "r", encoding="utf-8") as f:
        data = yaml.safe_load(f)
    references = data.get("references", [])

    # Ensure output directories exist
    PDF_DIR.mkdir(parents=True, exist_ok=True)
    PNG_DIR.mkdir(parents=True, exist_ok=True)
    OUTPUT_MD.parent.mkdir(parents=True, exist_ok=True)

    folder_url = ""
    if references:
        folder_url = references[0].get("folder_url", "")

    for ref in references:
        title = ref["title"]
        pdf_name = ref["pdf"]
        pdf_path = PDF_DIR / pdf_name

        if not pdf_path.exists():
            print(f"Warning: PDF not found: {pdf_path}", file=sys.stderr)
            continue

        print(f"Processing {title}...")
        pdf_stem = pdf_name.replace(".pdf", "")
        output_prefix = PNG_DIR / pdf_stem

        # Convert PDF to PNGs
        page_count = convert_pdf_to_pngs(pdf_path, output_prefix)
        print(f"  Generated {page_count} page images")

        # Clean orphaned PNGs
        clean_orphaned_pngs(pdf_name, page_count)

    # Generate references.md
    md_content = generate_references_md(references, folder_url)
    with open(OUTPUT_MD, "w", encoding="utf-8") as f:
        f.write(md_content)

    print(f"Generated {OUTPUT_MD} ({len(md_content)} bytes)")


if __name__ == "__main__":
    main()
