# references-pages — Generated PNG Fallback for Inline PDF Previews

This folder holds **generated PNG page images** used as a fallback when the IG
Publisher renders the References page and the browser (especially on mobile)
cannot show the embedded PDF inline.

## Source vs. Generated

| What | Path | Role |
|---|---|---|
| **Canonical source PDFs** | `input/images/references/*.pdf` | Hand-curated DOH / PhilHealth policy documents. Do not edit by hand. Replace the file when a new version is issued. |
| **Generated PNG fallbacks** | `input/images/references-pages/*.png` | One PNG per PDF page, produced automatically by the generation script. These are disposable artifacts. |
| **References page** | `input/pagecontent/references.md` | Auto-generated. Embeds PDFs via `<object>` with a `<div>` fallback referencing these PNGs. |
| **Metadata** | `input/references.yaml` | Maps each PDF title → filename → Google Drive URL. Add new entries here. |

## How to Regenerate

```bash
python input/generate_references.py
```

- The script reads `input/references.yaml`, locates PDFs in `input/images/references/`,
  converts each to page images via `pdftoppm` (from poppler), and writes
  `references-pages/page-name-page-01.png`, `page-02.png`, … plus the full
  `references.md`.
- It is **idempotent** — safe to re-run at any time.
- **Orphan cleanup**: if a PDF shrinks in page count, stale PNGs are removed
  automatically.

### Requirements

- `pdftoppm` (from `poppler`): `brew install poppler` (macOS) /
  `sudo apt-get install poppler-utils` (Debian/Ubuntu)
- Python 3 + PyYAML: `pip install pyyaml`

## Cleanup

All files in this folder are regenerable. To start fresh:

```bash
rm -rf input/images/references-pages/
python input/generate_references.py
```

## Why PNGs Instead of Just PDFs?

Mobile browsers often lack a native PDF renderer, so an `<object>` tag pointing
to a PDF may show a blank or broken area. These generated page images serve as
a universal fallback that works on every device without requiring `pdftoppm`
at IG render time.

## See Also

- `AGENTS.md` — section *Content Generation Scripts / Reference Pages* for
  the full build workflow.
- `input/generate_references.py` — the script that produces everything in this
  folder.
