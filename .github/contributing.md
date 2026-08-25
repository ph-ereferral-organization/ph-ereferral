# Contributing to PH eReferral Implementation Guide

Thank you for your interest in contributing to the PH eReferral Implementation Guide! This document provides guidelines and instructions for contributing to this FHIR Implementation Guide (IG) project.

> **Living Document Notice:** The heuristics and decision principles in this guide are subject to change as the IG undergoes review and edge cases are discovered. The PH eReferral team is actively refining these rules through implementation experience. **This guide will be updated accordingly** as agreements evolve—contributors should expect changes and check for the latest version when contributing.

---

## Table of Contents

1. [PH eReferral Philosophy](#ph-ereferral-philosophy)
2. [Profile Inclusion Criteria](#profile-inclusion-criteria)
3. [Profile Development Rules](#profile-development-rules)
4. [Profile Reference Hierarchy](#profile-reference-hierarchy)
5. [How to Submit Issues and Pull Requests](#how-to-submit-issues-and-pull-requests)
6. [Coding Style Guidelines](#coding-style-guidelines)
7. [Branching Strategy](#branching-strategy)
8. [Process for Code Review](#process-for-code-review)
9. [Development Setup](#development-setup)
10. [Internal Contributing Workflow](#internal-contributing-workflow)
11. [Additional Resources](#additional-resources)

---

## PH eReferral Philosophy

### Mission Statement

> PH eReferral defines the **minimum data and workflow requirements for patient referrals across the Philippine health system**, extending PH Core with referral-specific constraints and extensions.

### Key Concepts

| Concept | Description |
|---------|-------------|
| **Referral Focus** | eReferral captures data elements specific to the patient referral workflow—from the referring facility to the receiving facility |
| **PH Core Extension** | eReferral builds on PH Core profiles; it does not redefine what PH Core already provides |
| **Interoperability** | Enables seamless exchange of referral data between different health facilities and systems |

### Comparison with Peer IGs

| IG | Role |
|----|------|
| **PH Core** | National baseline (floor) for Philippine health data |
| **PH eReferral** | Referral-specific extensions and workflows on top of PH Core |

---

## Profile Inclusion Criteria

### Standard Rule: The Referral Relevance Rule

A resource or data element is eligible for PH eReferral when it is **specific to the referral workflow** and not already covered by PH Core.

**Rationale:** This ensures eReferral contains only referral-specific components, avoiding overlap with PH Core while enabling true interoperability.

**Process:**
1. Identify the referral workflow step (e.g., patient demographics, referral request, encounter, task)
2. Check if PH Core already has a profile for this resource
3. If yes → extend the PH Core profile with referral-specific constraints
4. If no → profile the base FHIR resource with eReferral constraints
5. Document the justification in the profile's FSH comments

### Exception Rule: Human Appraisal

The referral relevance rule may be waived through **human appraisal** when:
- The element has **high policy priority** for referrals (e.g., mandated by DOH)
- The element **enables critical referral interoperability** despite limited current adoption
- The element is **essential for patient safety** during referral transitions

### Documentation Requirement

When bypassing the standard rule, the justification must be documented in:
1. The profile's FSH comments
2. The issue/PR description
3. The decision log

---

## Profile Development Rules

> **Note:** These rules represent the current team consensus. They are subject to refinement as edge cases are identified and the IG matures.

### Rule Summary Table

| Rule | Description | Example |
|------|-------------|---------|
| **Rule 1: Extend PH Core First** | Always extend PH Core profiles when available | `Parent: PHCorePatient` not `Parent: Patient` |
| **Rule 2: ERef Prefix** | Use `ERef` prefix for eReferral-specific profiles | `ERefPatient`, `ERefServiceRequest` |
| **Rule 3: Cardinality → Obligation** | Map cardinality to Must Support + Obligation | `1..1` → `ObligationRequired` |
| **Rule 4: Example-Driven** | Every profile must have at least one example | `input/fsh/examples/` |

### Detailed Rules

#### Rule 1: Extend PH Core First

Always extend PH Core profiles when available. Only use base FHIR R4 when PH Core does not have a profile.

```fsh
// CORRECT: Extend PH Core
Profile: ERefPatient
Parent: PHCorePatient
Id: ereferral-patient

// INCORRECT: Extending base FHIR when PH Core exists
Profile: ERefPatient
Parent: Patient
```

#### Rule 2: ERef Prefix

Use `ERef` prefix for all eReferral-specific profiles:

| Resource Type | Profile Name | ID |
|---------------|--------------|-----|
| Patient | `ERefPatient` | `ereferral-patient` |
| ServiceRequest | `ERefServiceRequest` | `ereferral-service-request` |
| Encounter | `ERefEncounter` | `ereferral-encounter` |

#### Rule 3: Cardinality → Obligation Mapping

Map cardinality constraints to Must Support flags and obligation extensions:

```fsh
// Required element
* status 1..1 MS
* status insert ObligationRequired

// Optional element
* birthDate 0..1 MS
* birthDate insert ObligationOptional
```

#### Rule 4: Example-Driven

Every profile must have at least one example in `input/fsh/examples/`:

```fsh
Instance: ExampleERefPatient
InstanceOf: ERefPatient
Usage: #example
Title: "Example eReferral Patient"
Description: "An example patient for a cardiology referral."
```

---

## Profile Reference Hierarchy

### Reference Priority Order

When profiles reference other resources, follow this priority:

1. **PH Core profiles FIRST** (when available)
2. **eReferral profiles SECOND** (for referral-specific references)
3. **Base FHIR R4 resources THIRD** (when neither PH Core nor eReferral has a profile)

### Example FSH Pattern

```fsh
// CORRECT: PH Core first, then eReferral, then base FHIR
* subject only Reference(PHCorePatient)
* encounter only Reference(ERefEncounter)
* basedOn only Reference(ERefServiceRequest)
* performer.actor only Reference(PHCorePractitioner or PHCorePractitionerRole)
```

---

## How to Submit Issues and Pull Requests

### Submitting Issues

#### Before submitting an issue:

* **Search Existing Issues:** Check if your issue has already been raised.
* **Provide Clear Details:**
  * **Issue Title:** A concise title that summarizes the problem.
  * **Description:** A detailed description of the issue.
  * **Reproduction Steps:** Clear steps to reproduce.
  * **Expected Behavior:** What you expected to happen.
  * **Actual Behavior:** What actually happened.
  * **Environment Details:** Relevant version and system details.

#### Issue Prefixes

| Prefix | Description |
|--------|-------------|
| `[BUG]` | Bug reports |
| `[FR]` | Feature Request |
| `-[FR-A]` | Add |
| `-[FR-R]` | Read |
| `-[FR-D]` | Delete |
| `-[FR-U]` | Update |
| `-[FR-O]` | Others |
| `[T]` | Task |

### Submitting Pull Requests

1. **Fork the Repository** (external contributors) or **create a branch** (internal team)
2. **Clone/Checkout:**
   ```bash
   git clone https://github.com/YOUR-USERNAME/ph-ereferral.git
   git checkout -b feat-short-description
   ```
3. **Make Changes:** Follow the [Coding Style Guidelines](#coding-style-guidelines)
4. **Build and Test Locally:**
   ```bash
   # Generate FHIR resources
   sushi .

   # Build the IG
   ./_genonce.sh  # macOS/Linux
   _genonce.bat   # Windows
   ```
5. **Commit:**
   ```bash
   git commit -m "Description (#N)"
   ```
6. **Push:**
   ```bash
   git push origin feat-short-description
   ```
7. **Create a Pull Request:** Include:
   * A clear description of your changes.
   * A reference to relevant issues: `Fixes #N`.
   * Test results and validation output.

---

## Coding Style Guidelines

### FSH Guidelines

* **Indentation:** Use 2 spaces for line continuations. Top-level declarations have no indentation.
* **Line Length:** Limit lines to 100 characters.
* **File Organization:** Flat structure in `input/fsh/` with subdirectories for `profiles/`, `examples/`, `terminology/`, `extensions/`, `ruleSets/`.

### Naming Conventions

| Element Type | FSH Name Pattern | ID Pattern | Example |
|--------------|------------------|------------|---------|
| **Profile** | `ERef{Resource}` | `ereferral-{resource}` | `ERefPatient`, `ereferral-patient` |
| **Extension** | `{PascalCase}` | `{kebab-case}` | `ReferralPriorityExtension`, `ereferral-referral-priority` |
| **CodeSystem** | `{Name}CS` or `{ACRONYM}` | `{kebab}-cs` | `eReferralWorkflowCodesCS`, `e-referral-workflow-codes` |
| **ValueSet** | `{Name}VS` | `{kebab}-vs` | `eReferralServiceRequestVS`, `e-referral-service-request-vs` |
| **Example** | `{resource}-{scenario}-example` | (same) | `patient-cardiology-referral-example` |
| **RuleSet** | `{PascalCaseDescription}` | (inline) | `ObligationRequired` |
| **Alias (External)** | `${UPPERCASE}` | N/A | `$sct`, `$PSGC` |
| **Alias (Actor)** | `${lowercase}` | N/A | `$server`, `$creator` |

### Key Points
- Profile names use `ERef` prefix
- Extensions do NOT use `ERef` prefix (implicitly eReferral)
- CodeSystems use `CS` suffix OR official acronym
- ValueSets use `VS` suffix
- Examples use `-example` suffix
- Aliases: external terminology = UPPERCASE, actors = lowercase

### FSH File Organization

```fsh
// 1. Aliases (if any)
Alias: $sct = http://snomed.info/sct

// 2. Profile definition
Profile: ERefPatient
Parent: PHCorePatient
Id: ereferral-patient
Title: "ERefPatient"
Description: "Patient profile for Philippine eReferral."

// 3. Rules
* name 1..*
* name insert ObligationRequired

// 4. Invariants
Invariant: ereferral-patient-1
Description: "If contact is provided, either name or telecom must be present."
Severity: #error
Expression: "contact.exists() implies contact.all(name.exists() or telecom.exists())"
```

### Comments

* Use `//` for inline comments.
* Add comments for complex rules or business logic.
* **TDG References:** Format as `// TDG Row REF-XX: "{element}" -> {FHIR path}`

### Testing

* Ensure FSH compiles with `sushi .` (0 Errors, 0 Warnings)
* Provide examples for new profiles.
* Validate the IG builds successfully before submitting a PR.

---

## Branching Strategy

> **Important:** Branch names must **NOT** contain `/` or other special characters that may cause issues with the FHIR auto-IG builder.
>
> **Correct:** `feat-create-medication-series`, `fix-patient-profile`
> **Incorrect:** `feat/create-medication-series`, `bug_fix/validator`

### Main Branches

* **main:** Latest working code. New features merge here.

### Feature Branches

* Create from `main` for new features or bug fixes.
* Format: `{type}-{issue-number}-{description}` (e.g., `feature-272-contributing-md`, `fix-156-patient-binding`)
* Merge back into `main` when done.

### Hotfix Branches

* For urgent production bugs: `hotfix-short-description` from `main`, fix, merge back.

---

## Process for Code Review

### Automated Checks

* CI pipeline checks for build success, SUSHI compilation, and validation.
* Ensure all checks pass before submitting the PR.

### Reviewer Assignment

* A project maintainer will be assigned to review your PR.
* Checks for: code correctness, FHIR compliance, style adherence, test coverage.

### Feedback

* Address reviewer comments by pushing additional commits to the same branch.

### Approval and Merging

* Once approved, the PR will be **squash merged** into `main`.
* Delete the feature branch after merge.

### Reviewer Checklist

- Does the IG build locally and in CI?
- Are new artifacts linked in the IG?
- Are identifiers and canonical URLs correct?
- Are changes documented in PR notes?

---

## Development Setup

### Prerequisites

#### A. Java

* Install JDK 11+.
* Set `JAVA_HOME` and ensure `java -version` works.

#### B. Node.js & SUSHI

```bash
nvm install 18
nvm use 18
npm install -g fsh-sushi
```

#### C. Git

```bash
git --version
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

### Building & Validating

1. **Clone the Repository**
   ```bash
   git clone https://github.com/ph-ereferral-organization/ph-ereferral.git
   cd ph-ereferral
   ```

2. **Generate FHIR Resources**
   ```bash
   sushi .
   ```

3. **Update IG Publisher**
   ```bash
   ./_updatePublisher.sh  # macOS/Linux
   _updatePublisher.bat   # Windows
   ```

4. **Build the IG**
   ```bash
   ./_genonce.sh  # macOS/Linux
   _genonce.bat   # Windows
   ```

5. **Preview**
   Open `output/index.html` in your browser.

---

## Internal Contributing Workflow

For PH eReferral team members:

### Branching

1. Create issue in GitHub
2. Create branch from GitHub UI or run:
   ```bash
   git pull origin
   git checkout {branch-name}
   ```

### Commit & PR

* Make small, focused commits.
* Build and test locally before pushing.
* Push and open a PR to `main`.

### Pull Request Policy

1. Only merge when **CI is green**.
2. **Merge notes required**.
3. **Preferred merge method:** Squash and Merge.
4. **Delete the feature branch** after merge.
5. **Mark all files as reviewed** in GitHub UI.

---

## Additional Resources

- **PH eReferral IG Build**: https://build.fhir.org/ig/ph-ereferral-organization/ph-ereferral
- **PH Core IG Build**: https://build.fhir.org/ig/UP-Manila-SILab/ph-core
- **FHIR R4 Specification**: https://hl7.org/fhir/R4/index.html
- **SUSHI Documentation**: https://fshschool.org/
- **Issue Tracker**: https://github.com/ph-ereferral-organization/ph-ereferral/issues

### Reference Implementations

- [AU Base](https://github.com/hl7au/au-fhir-base)
- [AU Core](https://github.com/hl7au/au-fhir-core)
- [US Core](https://github.com/HL7/US-Core)
- [UK Core](https://github.com/NHSDigital/FHIR-R4-UKCORE)

---

## Questions?

- Open an issue: https://github.com/ph-ereferral-organization/ph-ereferral/issues
- See the [PH eReferral AGENTS.md](../AGENTS.md) for the full engineering guide.

Thank you for contributing to Philippine health interoperability!
