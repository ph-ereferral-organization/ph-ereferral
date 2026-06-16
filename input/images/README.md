# input/images — IG Image Assets

This folder holds images, source data, and generated fallback assets for the
PH eReferral Implementation Guide narrative pages.

## Directory Layout

```
input/images/
├── README.md                    ← This file
├── data-dictionary.csv          ← Source data (hand-curated)
├── minimum-viable-workflow.png  ← Standalone image asset
├── references/                  ← Canonical DOH/PhilHealth PDFs (hand-curated)
└── references-pages/            ← Generated PNG page images (disposable)
```

## Source vs. Generated

| Asset | Path | Role |
|---|---|---|
| **Reference PDFs** | `references/*.pdf` | Hand-curated DOH / PhilHealth policy documents. Do not edit by hand. Replace the file when a new version is issued. |
| **Reference PNGs** | `references-pages/*.png` | One PNG per PDF page, produced automatically. These are **disposable artifacts**. |
| **Data Dictionary CSV** | `data-dictionary.csv` | Hand-curated TDG-to-FHIR mapping. Source for the Data Dictionary table. |
| **Workflow image** | `minimum-viable-workflow.png` | Standalone image used in narrative pages. |

## How to Regenerate

### Reference Page PNGs

```bash
python input/generate_references.py
```

- Reads `references.yaml` → PDFs in `references/` → outputs PNGs to
  `references-pages/` + rewrites `input/pagecontent/references.md`.
- **Idempotent** — safe to re-run.
- **Orphan cleanup** — stale PNGs are removed automatically when a PDF shrinks.
- **Nuke-and-rebuild**: `rm -rf input/images/references-pages/` then re-run.

#### Requirements

- `pdftoppm` (from `poppler`): `brew install poppler` (macOS) /
  `sudo apt-get install poppler-utils` (Debian/Ubuntu)
- Python 3 + PyYAML

### Data Dictionary Table

```bash
python input/generate_data_dictionary_table.py
```

- Reads `data-dictionary.csv` → writes `input/includes/data-dictionary-table.html`.
- **Idempotent** — safe to re-run.

## Why PNGs for References?

Mobile browsers often lack a native PDF renderer, so an `<object>` tag pointing
to a PDF may show a blank or broken area. These generated page images serve as
a universal fallback that works on every device without requiring `pdftoppm`
at IG render time.

## See Also

- `AGENTS.md` — section *Content Generation Scripts* for the full build workflow.
- `input/generate_references.py` — script that produces `references-pages/`.
- `input/generate_data_dictionary_table.py` — script that consumes `data-dictionary.csv`.
