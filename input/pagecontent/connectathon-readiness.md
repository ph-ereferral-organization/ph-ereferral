# v0.1 Connectathon Quick-Start, Test Pack, and Release Readiness

This page gives implementers and reviewers a minimum, repeatable path for testing the draft PH eReferral IG v0.1 content from a clean checkout. It separates the testable minimum path from background reference material so connectathon participants can tell the difference between an IG defect, a fixture defect, and a missing instruction.

## v0.1 Quick-Start

| Item | v0.1 expectation |
|------|------------------|
| Purpose | Validate the minimum PH eReferral workflow using the IG profiles and examples. |
| Intended users | IG authors, implementers, vendors, validators, and connectathon testers. |
| FHIR version | FHIR R4, version `4.0.1`. |
| IG version | `0.1.0`, release label `ci-build`. |
| Required dependency | PH Core package `fhir.ph.core` as configured in `sushi-config.yaml`. |
| Current continuous build | [PH eReferral continuous build](https://build.fhir.org/ig/ph-ereferral-organization/ph-ereferral/). Treat this as a CI build, not a tagged release. |
| Release tag | No versioned release tag is available yet. Use the [repository tags page](https://github.com/ph-ereferral-organization/ph-ereferral/tags) once issue [#73](https://github.com/ph-ereferral-organization/ph-ereferral/issues/73) is resolved. |

Minimum implementer setup:

1. Git client for cloning the repository.
2. Node.js and SUSHI for compiling FSH.
3. Java runtime compatible with the IG Publisher used by this repository.
4. Ruby/Jekyll where required by the local or CI publisher template.
5. Network access for first-time package and publisher downloads unless the needed packages are already cached.

## Build and Validate the IG

Clone the repository:

```bash
git clone https://github.com/ph-ereferral-organization/ph-ereferral.git
cd ph-ereferral
```

Compile FSH only:

```bash
sushi .
```

Expected SUSHI result:

- `fsh-generated/resources/ImplementationGuide-fhir.ph.ereferral.json` is generated.
- The summary reports `0 Errors`.
- If `fhir.ph.core#dev` is not cached locally, SUSHI may fall back to the locally available PH Core package. Record that package state in test evidence.

Run the full IG build on Windows:

```bat
_genonce.bat
```

Run the full IG build on macOS or Linux:

```bash
./_genonce.sh
```

Run the Publisher directly in offline terminology mode:

```bash
java -jar input-cache/publisher.jar -ig . -tx n/a
```

Expected Publisher result:

- `output/index.html` and `output/qa.html` are produced.
- The command exits successfully.
- `output/qa.html` is reviewed for errors, warnings, broken links, and terminology limitations before claiming release readiness.

Known build limitations:

- Issue [#73](https://github.com/ph-ereferral-organization/ph-ereferral/issues/73) tracks versioned release infrastructure. Until it is resolved, testers should cite commit hashes or branch build URLs, not a formal release URL.
- Offline terminology mode can report terminology expansion limitations that must be distinguished from profile or example defects.
- If the local build uses a cached PH Core package instead of `fhir.ph.core#dev`, record the actual package used in the evidence table.

## Minimum By-Hand Test

Use this as the connectathon smoke test from a clean checkout with the listed fixtures. The expected result is a traceable referral request that moves from creation, to receiving-facility response, to closure.

| Step | Action | Fixture or artifact | Expected result |
|------|--------|---------------------|-----------------|
| 1 | Create referral | [Example eReferral ServiceRequest](ServiceRequest-ExampleERefServiceRequest.html) | A referral request exists with `status = active`, `intent = order`, an urgent priority, a patient subject, a requester, a receiving facility, clinical reason, and supporting observations. |
| 2 | Send referral | [Example eReferral Task - Requested State](Task-ExampleERefTaskRequested.html) | A workflow Task exists with `status = requested`, focused on the ServiceRequest. The requester is populated and the receiving owner is not yet assigned. |
| 3 | Receive referral | [Example eReferral Task - Accepted State](Task-ExampleERefTaskAccepted.html) | The receiving facility has accepted ownership of the referral Task and `owner` is populated. |
| 4 | Respond with receiving-facility outcome | [Example eReferral Task - Accepted State](Task-ExampleERefTaskAccepted.html) | For the current v0.1 minimum fixture, the positive receiving response is represented by `Task.status = accepted`. Richer response-state semantics are pending review in issue [#47](https://github.com/ph-ereferral-organization/ph-ereferral/issues/47) and PR [#84](https://github.com/ph-ereferral-organization/ph-ereferral/pull/84). |
| 5 | Close referral | [Example eReferral Task - Completed State](Task-ExampleERefTaskCompleted.html) and [Example eReferral Encounter](Encounter-ExampleERefEncounter.html) | The Task is completed, completion output is present, and the receiving encounter documents the completed referral encounter. |

Pass criteria for the by-hand test:

- Required examples render in the IG.
- The ServiceRequest references the patient, requester, receiving facility, reason, and supporting clinical information needed for the scenario.
- The Task examples preserve a coherent state progression from requested to accepted to completed.
- The close step records a completion output and a receiving encounter.

Fail criteria:

- A required fixture is missing from the rendered IG.
- A required reference cannot be followed.
- The state progression cannot be explained using the current v0.1 artifacts.
- QA reports a broken link for a required profile, example, or page used in this test.

## Test Data Pack

Required fixtures for the minimum test:

| Fixture | Link | Test role |
|---------|------|-----------|
| Referral request | [Example eReferral ServiceRequest](ServiceRequest-ExampleERefServiceRequest.html) | Primary referral order under test. |
| Patient | [Example eReferral Patient](Patient-ExampleERefPatient.html) | Referral subject. |
| Referring practitioner | [Example Referring Practitioner](Practitioner-ExampleERefPractitioner.html) | Clinician creating the referral. |
| Referring practitioner role | [Example Referring Practitioner Role](PractitionerRole-ExampleERefPractitionerRole.html) | Links practitioner to referring facility. |
| Referring facility | [Example Referring Facility](Organization-ExampleERefReferringFacility.html) | Initiating facility. |
| Receiving facility | [Example Receiving Hospital](Organization-ExampleERefReceivingHospital.html) | Intended receiving facility. |
| Clinical condition | [Example Condition - Chest Pain](Condition-ExampleERefConditionChestPain.html) | Referral reason evidence. |
| Blood pressure observation | [Example Blood Pressure Observation](Observation-ExampleERefObservationBP.html) | Supporting clinical information. |
| ECG observation | [Example ECG Observation](Observation-ExampleERefObservationECG.html) | Supporting clinical information. |
| Requested Task | [Example eReferral Task - Requested State](Task-ExampleERefTaskRequested.html) | Sent referral workflow state. |
| Accepted Task | [Example eReferral Task - Accepted State](Task-ExampleERefTaskAccepted.html) | Receiving-facility response state currently available in v0.1 fixtures. |
| Completed Task | [Example eReferral Task - Completed State](Task-ExampleERefTaskCompleted.html) | Closed referral state. |
| Receiving encounter | [Example eReferral Encounter](Encounter-ExampleERefEncounter.html) | Completed referral encounter context. |

Optional fixtures:

| Fixture | Link | Optional use |
|---------|------|--------------|
| Provenance signature | [Example eReferral Provenance with Signature](Provenance-ExampleERefProvenanceSignature.html) | Demonstrates signature attestation. |
| Provenance update | [Example eReferral Provenance for Status Update](Provenance-ExampleERefProvenanceUpdate.html) | Demonstrates status update audit trail. |
| Medication administration | [Example Chronic Medication Administration](MedicationAdministration-ExampleERefMedicationAdministrationChronic.html) | Clinical summary support. |
| Antibiotic administration | [Example Antibiotic Administration](MedicationAdministration-ExampleERefMedicationAdministrationAntibiotic.html) | Treatment-given support. |
| Immunization | [ERefImmunization Example - Routine Immunization](Immunization-ExampleERefImmunizationRoutine.html) | Immunization support. |

## Automated or Semi-Automated Testing

Available checks:

- `sushi .` checks FSH syntax, generates JSON resources, and catches duplicate instance names.
- `_genonce.bat` or `./_genonce.sh` runs the project build path.
- `java -jar input-cache/publisher.jar -ig . -tx n/a` runs an offline Publisher build that can be used when terminology server access is slow or unavailable.
- GitHub Actions runs repository validation on pull requests according to `.github/workflows/validate-docs.yml`.

Not yet available:

- There is no executable connectathon workflow test script that automatically performs create/send/receive/respond/close assertions.
- There is no multi-server exchange test harness in this repository.

For v0.1, passing the automated build does not replace the by-hand test. It only proves that the IG artifacts can be generated and validated by the available build tooling.

## Test Evidence Summary

Record one row per connectathon run, release candidate, or reviewer verification.

| Evidence field | Value to record |
|----------------|-----------------|
| What was tested | Minimum create, send, receive, respond, and close referral path using the fixtures listed above. |
| Who tested it | Tester name, organization, and role. |
| Date tested | Calendar date in `YYYY-MM-DD` format. |
| Build or commit tested | Release tag, branch build URL, or commit SHA. |
| Build result | SUSHI result, Publisher result, and QA summary. |
| By-hand test result | Pass, fail, or pass with limitations. |
| Known unresolved issues | Links to unresolved issues that affect interpretation of the result. |

Current v0.1 readiness status:

- The minimum test path is documented.
- The fixture set is identified.
- Formal connectathon execution evidence has not yet been recorded in this repository.

## Known Limitations for v0.1

- Receiving-facility response semantics are still pending review in issue [#47](https://github.com/ph-ereferral-organization/ph-ereferral/issues/47) and PR [#84](https://github.com/ph-ereferral-organization/ph-ereferral/pull/84). The currently published minimum fixture supports requested, accepted, and completed Task states.
- Non-response and SLA handling are deferred until timing and escalation rules are formally defined.
- Facility and network identification examples use facility identifiers for testing, but operational registry lookup, HCPN membership, and routing rules are not fully specified in this v0.1 test pack.
- Attachment exchange, consent, authentication, authorization, transport security, and data-protection controls are outside the current by-hand test.
- Back-referral is part of the broader policy basis, but it is not included in the minimum v0.1 connectathon path.
- Multi-server testing has not yet been completed.
- Versioned release deployment is pending issue [#73](https://github.com/ph-ereferral-organization/ph-ereferral/issues/73).

## Release Readiness Documentation

Use these linked pages when preparing or reviewing a v0.1 release candidate:

- [v0.1 Scope and Release Notes](v01-scope.html)
- [v0.1 Coverage Map](coverage-map.html)
- [v0.1 Decision Log and ADR Status](decision-log.html)

Release-readiness checklist for v0.1:

- SUSHI completes with `0 Errors`.
- The IG Publisher completes and `output/qa.html` is reviewed.
- Required fixtures in the test data pack render and links are valid.
- The by-hand test is executed and evidence is recorded.
- Known limitations are accepted or converted into release blockers.
- TDG technical review confirms the workflow and terminology interpretation.
- Product owner review confirms the v0.1 release scope.
