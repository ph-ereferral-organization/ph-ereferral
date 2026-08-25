# PH eReferral IG - Vibe Engineering Guide

## Build Commands

### Full IG Build (IG Publisher)

**macOS/Linux:**
- **One-time build**: `./_genonce.sh` (auto-detects online/offline)
- **Interactive menu**: `./_build.sh` then select:
  - **Option 2**: Full build (with terminology server) - echo "2" | ./_build.sh
  - **Option 4**: Build without TX server (offline, faster for large codesystems) - echo "4" | ./_build.sh

**Windows:**
- **One-time build**: `_genonce.bat` (auto-detects online/offline)
- **Interactive menu**: `_build.bat` then select Option 2 or 4 - echo "2" | ./_build.bat or - echo "4" | ./_build.bat

**Direct commands (all platforms):**
- With terminology: `java -jar input-cache/publisher.jar -ig .`
- Offline (no TX): `java -jar input-cache/publisher.jar -ig . -tx n/a`

### Quick Build (SUSHI only) - Avoid
- Optional for profile checks, but not when testing examples/ and pagecontent/ items
- **Compile FSH to JSON**: `sushi .`
  - Converts FSH files to FHIR JSON resources in `fsh-generated/`
  - Fast - use for quick validation of FSH syntax
  - **IMPORTANT: SUSHI alone is not sufficient for validation.** The IG Publisher catches errors that SUSHI misses (e.g., `BUNDLE_ENTRY_URL_ABSOLUTE`, broken HTML links, full-url vs reference mismatches). Always run a full publisher build after any change to examples, page content, or FSH profiles.
  - Not recommended for debugging examples with terminology (Please use other below)


### Other Commands

**Update publisher:**
- macOS/Linux: `./_updatePublisher.sh`
- Windows: `_updatePublisher.bat`

**Clean temp directories:**
- macOS/Linux: `./_build.sh clean`
- Windows: `_build.bat clean`

> **Pattern:** [Local Build Parity](https://fhirpatterns.net/ig-authoring-patterns/patterns/local-build-parity/) — The equivalent macOS/Linux/Windows build scripts above follow this pattern: every developer should be able to reproduce the CI build locally. See also [GitHub Actions Pipeline](https://fhirpatterns.net/ig-authoring-patterns/patterns/github-actions-pipeline/) for the CI workflow structure in `.github/workflows/`.

### Content Generation Scripts

The following scripts live in `input/` and regenerate derived content before building.

**Data Dictionary Table (from CSV):**
```bash
python input/generate_data_dictionary_table.py
```
- Reads: `input/images/data-dictionary.csv`
- Writes: `input/includes/data-dictionary-table.html`
- Path-agnostic — resolves relative to the script location.

**Reference Pages (from PDFs + YAML):**
```bash
python input/generate_references.py
```
- Reads: `input/references.yaml` (metadata for each PDF)
- Reads: `input/images/references/*.pdf`
- Writes: `input/images/references-pages/*.png` (one per page)
- Writes: `input/pagecontent/references.md` (auto-generated inline preview)
- Requirements: `pdftoppm` (from poppler-utils / poppler package)
  - macOS: `brew install poppler`
  - Ubuntu/Debian: `sudo apt-get install poppler-utils`
- Idempotent — safe to re-run; cleans orphaned PNGs if page counts change.

### Table Styling Convention

All markdown tables in narrative pages must be wrapped in `<div class="ph-table" markdown="1">` to receive consistent styling from `input/includes/fragment-css.html`:

```markdown
<div class="ph-table" markdown="1">

| Header | Header |
|--------|--------|
| Cell   | Cell   |

</div>
```

This ensures tables receive the `.ph-table` CSS (light headers, borders, zebra striping) without affecting generated artifacts pages like `artifacts.html` or `index.html`.

## Architecture

- **Type**: FHIR R4 Implementation Guide using SUSHI/FSH
- **Main config**: `sushi-config.yaml` (IG metadata, dependencies on PH Core)
- **IG config**: `ig.ini` (publisher settings)
- **Source**: FSH definitions, narrative content, and configuration in `input/`
- **Generated**: SUSHI output, final IG documentation, and temporary build products
- **Publisher**: HL7 FHIR IG Publisher (Java-based)
- **Canonical base**: `https://fhir.doh.gov.ph/pheref`
- **Dependencies**: `fhir.ph.core` (Philippines Core Implementation Guide)

## Code Style & Conventions

- **FSH files**: Profiles, extensions, code systems, value sets defined in FHIR Shorthand
- **Vocabulary**: Code systems tracked in `input/fsh/terminology/`
- **Content**: Markdown pages in `input/pagecontent/` and images for IG documentation
- **Examples**: Instance examples in `input/fsh/examples/`
- **ID pattern**: Use camelCase (e.g., `eRefPatient`, `eRefServiceRequest`)
- **Branch naming**: Use hyphens, never slashes (e.g., `feat-name` not `feat/name`)
- **Bundle entry `fullUrl`**: Always use `urn:uuid:xxx` for transaction bundle entry `fullUrl` values. The IG Publisher enforces `BUNDLE_ENTRY_URL_ABSOLUTE` — relative URLs like `Patient/Example` will fail validation. To make intra-bundle references resolve correctly, always set FSH references directly via `.reference = "urn:uuid:xxx"` instead of using `Reference(InstanceName)` so that both the `fullUrl` and the reference use the same `urn:uuid:` identifier.

> **Patterns:** [Standard IG Layout](https://fhirpatterns.net/ig-authoring-patterns/patterns/standard-ig-layout/) governs the `input/` directory structure used here. [FSH Authoring — Aliases and RuleSets](https://fhirpatterns.net/ig-authoring-patterns/patterns/aliases-and-rulesets/) and [Extensions and Slicing](https://fhirpatterns.net/ig-authoring-patterns/patterns/extensions-and-slicing/) cover FSH best practices. For profiling decisions, apply [Profile Minimalism with Justification](https://fhirpatterns.net/fhir-authoring-patterns/patterns/pl-12/) and [Example-Driven Profiling](https://fhirpatterns.net/fhir-authoring-patterns/patterns/pl-14/) — constrain only what is clinically necessary, and drive profile shape from concrete examples. See also [FSH-First, Repo-First Authoring](https://fhirpatterns.net/fhir-authoring-patterns/patterns/pl-06/) and [Package-First IG Layout](https://fhirpatterns.net/fhir-authoring-patterns/patterns/pl-07/) for the broader authoring philosophy this repo follows.

## Contribution Workflow

1. Check for existing issue or create one using templates
2. Branch from `main` with descriptive name (no `/` characters)
3. Reference issue in commits: `git commit -m "Description (#48)"`
4. Open PR linking to issue: `Fixes #48`
5. Merge only when CI is green, use squash merge, delete branch after

> **Patterns:** Issue and PR structure follows [Issue Templates](https://fhirpatterns.net/ig-authoring-patterns/patterns/issue-templates/) and [PR Templates & CODEOWNERS](https://fhirpatterns.net/ig-authoring-patterns/patterns/pr-templates-and-codeowners/). Each issue type maps to a structured artifact with a [Definition-of-Done per Artifact](https://fhirpatterns.net/fhir-authoring-patterns/patterns/pl-05/) checklist.

## Address Conventions — PSGC Geographic Codes

PH Core provides a `PHCoreAddress` datatype profile (`input/fsh/profiles/ph-core-address.fsh`) that adds four named extension slices for Philippine Standard Geographic Codes (PSGC) to the base FHIR `Address` type:

| Extension Slice | PSGC Level | Example Code |
|---|---|---|
| `region` | Region | `$PSGC#0600000000` "Region VI (Western Visayas)" |
| `province` | Province | `$PSGC#0600400000` "Aklan" |
| `cityMunicipality` | City / Municipality | `$PSGC#0600407000` "Kalibo" |
| `barangay` | Barangay | `$PSGC#0600407013` "Poblacion" |

The `$PSGC` alias resolves to `https://psa.gov.ph/classification/psgc` (defined in `input/fsh/aliases.fsh`).

### Correct PSGC Address Pattern (Named Slices)

Use the named extension slices inherited from `PHCoreAddress`. Never use `address.city`, `address.state`, or `address.district` — these are replaced by the PSGC extensions:

```fsh
* address.use = #work
* address.line = "123 Hospital Street"
* address.postalCode = "1740"
* address.country = "PH"
* address.extension[region].valueCoding = $PSGC#1300000000 "National Capital Region (NCR)"
* address.extension[province].valueCoding = $PSGC#0402100000 "Cavite"
* address.extension[cityMunicipality].valueCoding = $PSGC#1380200000 "City of Las Piñas"
* address.extension[barangay].valueCoding = $PSGC#1380100001 "Barangay 1"
```

### Allowed Flat Address Fields

Only these base `Address` fields may be used directly (they have no PSGC equivalent):

| Field | Usage |
|---|---|
| `address.line` | Street address / building (repeatable, use `line[+]`) |
| `address.postalCode` | ZIP code |
| `address.country` | Always `"PH"` |
| `address.use` | `#home`, `#work`, etc. |
| `address.type` | `#physical`, `#postal`, `#both` |
| `address.text` | Human-readable address string |

### Legacy Pattern (Sequential Indexing)

The ph-core examples also demonstrate a legacy sequential indexing pattern. Prefer named slices when the profile already constrains `address only PHCoreAddress`:

```fsh
// Legacy pattern — use named slices instead
* address.extension.url = "https://fhir.doh.gov.ph/phcore/StructureDefinition/barangay"
* address.extension.valueCoding = $PSGC#1339000003 "Ermita"
* address.extension[+].url = "https://fhir.doh.gov.ph/phcore/StructureDefinition/city-municipality"
* address.extension[=].valueCoding = $PSGC#1380600000 "City of Manila"
```

## Organization Identifier Conventions (NHFR + HCPN)

All Organization instances in the eReferral IG must include at minimum an NHFR (National Health Facility Registry) identifier. HCPN (Health Care Provider Network) identifiers should also be present when the facility belongs to a known network. Receiving organizations must carry the same identifier systems as initiating organizations.

### Identifier Systems

| Identifier | System URL | Purpose |
|---|---|---|
| NHFR | `https://fhir.doh.gov.ph/phcore/Identifier/doh-nhfr-code` | DOH National Health Facility Registry code |
| HCPN | `https://fhir.doh.gov.ph/phcore/Identifier/hcpn-code` | Health Care Provider Network identifier |

### Organization Example Pattern

```fsh
Instance: ExampleOrganizationFacility
InstanceOf: PHCoreOrganization
* name = "Example Health Center"
* identifier[0].system = "https://fhir.doh.gov.ph/phcore/Identifier/doh-nhfr-code"
* identifier[0].value = "FAC-12345"
* identifier[+].system = "https://fhir.doh.gov.ph/phcore/Identifier/hcpn-code"
* identifier[=].value = "Aklan HCPN"
* address.line = "123 Hospital Road"
* address.postalCode = "5600"
* address.country = "PH"
* address.extension[region].valueCoding = $PSGC#0600000000 "Region VI (Western Visayas)"
* address.extension[province].valueCoding = $PSGC#0600400000 "Aklan"
* address.extension[cityMunicipality].valueCoding = $PSGC#0600407000 "Kalibo"
* address.extension[barangay].valueCoding = $PSGC#0600407013 "Poblacion"
```

> **Important:** Both initiating and receiving organization instances must include NHFR and HCPN identifiers, plus full PSGC-coded addresses. Never skip identifiers on receiving or onward-receiving facilities.

## Dependencies

This IG extends the **PH Core IG** (`fhir.ph.core`). For the complete and current list of inherited profiles, extensions, and terminology, see the PH Core IG at [build.fhir](https://build.fhir.org/ig/UP-Manila-SILab/ph-core) or the [PH Core Repository](https://github.com/UP-Manila-SILab/ph-core).

## Debugging Tips

- **SUSHI errors**: Check console output; common issues include unresolved aliases or incomplete slicing rules
- **Build hangs**: Use offline mode (`-tx n/a`) for faster builds when working with large codesystems
- **Validation**: Review `output/qa.html` for errors, warnings, and broken links
- **PH Core dependency issues**: Ensure `fhir.ph.core` package is downloaded (run `sushi .` to auto-download)

> **Pattern:** [Auto-Builder vs Local Builds](https://fhirpatterns.net/ig-authoring-patterns/patterns/auto-builder-vs-local/) covers the trade-offs between relying on the HL7 auto-builder and maintaining local build parity — relevant when diagnosing differences between local output and CI/published results.

## Resources

- **PH eReferral Repository**: https://github.com/ph-ereferral-organization/ph-ereferral
- **PH Core Repository**: https://github.com/UP-Manila-SILab/ph-core
- **Publisher**: https://github.com/HL7/fhir-ig-publisher
- **SUSHI/FSH**: https://fshschool.org/

## FHIR Pattern References

This IG applies patterns from the [FHIR Pattern Languages](https://fhirpatterns.net/) — a collection of reusable guidance for healthcare interoperability. Agents and contributors should consult these patterns when making structural, authoring, or tooling decisions.

### IG Authoring Patterns ([full catalog](https://fhirpatterns.net/ig-authoring-patterns/introduction/pattern-catalog/))

| Pattern | Relevance to this repo |
|---|---|
| [Standard IG Layout](https://fhirpatterns.net/ig-authoring-patterns/patterns/standard-ig-layout/) | `input/` directory structure, file placement conventions |
| [Local Build Parity](https://fhirpatterns.net/ig-authoring-patterns/patterns/local-build-parity/) | `_genonce.sh` / `_build.sh` scripts match CI behaviour |
| [GitHub Actions Pipeline](https://fhirpatterns.net/ig-authoring-patterns/patterns/github-actions-pipeline/) | `.github/workflows/validate-docs.yml` CI pipeline |
| [Issue Templates](https://fhirpatterns.net/ig-authoring-patterns/patterns/issue-templates/) | Structured issue types in `.github/ISSUE_TEMPLATE/` |
| [PR Templates & CODEOWNERS](https://fhirpatterns.net/ig-authoring-patterns/patterns/pr-templates-and-codeowners/) | PR checklist and review ownership |
| [Aliases and RuleSets](https://fhirpatterns.net/ig-authoring-patterns/patterns/aliases-and-rulesets/) | FSH alias and RuleSet conventions in `input/fsh/` |
| [Extensions and Slicing](https://fhirpatterns.net/ig-authoring-patterns/patterns/extensions-and-slicing/) | Extension definitions and slicing discipline |
| [Auto-Builder vs Local Builds](https://fhirpatterns.net/ig-authoring-patterns/patterns/auto-builder-vs-local/) | When to use HL7 auto-builder vs local publisher |
| [SemVer and Release Channels](https://fhirpatterns.net/ig-authoring-patterns/patterns/semver-and-channels/) | Versioning strategy for IG releases |

### FHIR Authoring Patterns ([full catalog](https://fhirpatterns.net/fhir-authoring-patterns/introduction/pattern-catalog/))

| Pattern | Relevance to this repo |
|---|---|
| [FSH-First, Repo-First Authoring](https://fhirpatterns.net/fhir-authoring-patterns/patterns/pl-06/) | All FHIR artifacts defined in FSH; repo is the source of truth |
| [Package-First IG Layout](https://fhirpatterns.net/fhir-authoring-patterns/patterns/pl-07/) | `sushi-config.yaml` and package structure |
| [Definition-of-Done per Artifact](https://fhirpatterns.net/fhir-authoring-patterns/patterns/pl-05/) | DoD checklists in issue templates and PRs |
| [Profile Minimalism with Justification](https://fhirpatterns.net/fhir-authoring-patterns/patterns/pl-12/) | Constrain only what is clinically required; document why |
| [Example-Driven Profiling](https://fhirpatterns.net/fhir-authoring-patterns/patterns/pl-14/) | Examples in `input/fsh/examples/` drive profile shape |

### FHIR Implementation Patterns ([full catalog](https://fhirpatterns.net/fhir-implementation-patterns/introduction/pattern-catalog/))

Patterns from this language are relevant for future referral system integration work (e.g., service discovery, capability negotiation, async invocation). Consult the catalog when designing inter-system interactions beyond the IG itself.
