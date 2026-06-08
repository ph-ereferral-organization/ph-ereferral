# PH eReferral IG - Vibe Engineering Guide

## Build Commands

### Quick Build (SUSHI only)
- **Compile FSH to JSON**: `sushi .`
  - Converts FSH files to FHIR JSON resources in `fsh-generated/`
  - Fast - use for quick validation of FSH syntax

### Full IG Build (SUSHI + IG Publisher)

**macOS/Linux:**
- **One-time build**: `./_genonce.sh` (auto-detects online/offline)
- **Interactive menu**: `./_build.sh` then select:
  - **Option 2**: Full build (with terminology server)
  - **Option 4**: Build without TX server (offline, faster for large codesystems)

**Windows:**
- **One-time build**: `_genonce.bat` (auto-detects online/offline)
- **Interactive menu**: `_build.bat` then select Option 2 or 4

**Direct commands (all platforms):**
- With terminology: `sushi . && java -jar input-cache/publisher.jar -ig .`
- Offline (no TX): `sushi . && java -jar input-cache/publisher.jar -ig . -tx n/a`

### Other Commands

**Update publisher:**
- macOS/Linux: `./_updatePublisher.sh`
- Windows: `_updatePublisher.bat`

**Clean temp directories:**
- macOS/Linux: `./_build.sh clean`
- Windows: `_build.bat clean`

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
- **Profile prefix**: Use `ERef` prefix for eReferral-specific profiles (e.g., `ERefPatient`, `ERefServiceRequest`)

## Contribution Workflow

1. Check for existing issue or create one using templates
2. Branch from `main` with descriptive name (no `/` characters)
3. Reference issue in commits: `git commit -m "Description (#48)"`
4. Open PR linking to issue: `Fixes #48`
5. Merge only when CI is green, use squash merge, delete branch after

## Dependencies

This IG extends the **PH Core IG** (`fhir.ph.core`). For the complete and current list of inherited profiles, extensions, and terminology, see the PH Core IG at [build.fhir](https://build.fhir.org/ig/UP-Manila-SILab/ph-core) or the [PH Core Repository](https://github.com/UP-Manila-SILab/ph-core).

## Debugging Tips

- **SUSHI errors**: Check console output; common issues include unresolved aliases or incomplete slicing rules
- **Build hangs**: Use offline mode (`-tx n/a`) for faster builds when working with large codesystems
- **Validation**: Review `output/qa.html` for errors, warnings, and broken links
- **PH Core dependency issues**: Ensure `fhir.ph.core` package is downloaded (run `sushi .` to auto-download)

## Resources

- **PH eReferral Repository**: https://github.com/ph-ereferral-organization/ph-ereferral
- **PH Core Repository**: https://github.com/UP-Manila-SILab/ph-core
- **Publisher**: https://github.com/HL7/fhir-ig-publisher
- **SUSHI/FSH**: https://fshschool.org/
