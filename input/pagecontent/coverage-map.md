# v0.1 Coverage Map

This page maps the v0.1 minimum referral workflow to the IG artifacts used by the connectathon readiness test.

## Workflow Coverage

| Workflow step | Primary artifact | Supporting artifacts | Coverage status |
|---------------|------------------|----------------------|-----------------|
| Create referral | [Example eReferral ServiceRequest](ServiceRequest-ExampleERefServiceRequest.html) | [EReferral ServiceRequest](StructureDefinition-ereferral-service-request.html), patient, practitioner role, organizations, condition, and observations | Covered for the minimum test path. |
| Send referral | [Example eReferral Task - Requested State](Task-ExampleERefTaskRequested.html) | [EReferral Task](StructureDefinition-ereferral-task.html) and [Example ServiceRequest for Task](ServiceRequest-ExampleERefServiceRequestTask.html) | Covered for a requested referral workflow state. |
| Receive referral | [Example eReferral Task - Accepted State](Task-ExampleERefTaskAccepted.html) | Receiving organization fixture and Task owner assignment | Covered through the accepted Task fixture. A separate received state is pending review. |
| Respond with receiving outcome | [Example eReferral Task - Accepted State](Task-ExampleERefTaskAccepted.html) | Issue [#47](https://github.com/ph-ereferral-organization/ph-ereferral/issues/47) and PR [#84](https://github.com/ph-ereferral-organization/ph-ereferral/pull/84) | Partially covered. Positive response is represented by accepted in the current fixture set. Rejected and referred-onward responses are pending review. |
| Close referral | [Example eReferral Task - Completed State](Task-ExampleERefTaskCompleted.html) | [Example eReferral Encounter](Encounter-ExampleERefEncounter.html) and Task output | Covered for completion of the minimum test path. |

## Profile Coverage

| Profile | v0.1 test role | Link |
|---------|----------------|------|
| EReferral ServiceRequest | Primary referral request | [StructureDefinition-ereferral-service-request.html](StructureDefinition-ereferral-service-request.html) |
| EReferral Task | Workflow state tracking | [StructureDefinition-ereferral-task.html](StructureDefinition-ereferral-task.html) |
| ERefEncounter | Receiving encounter context | [StructureDefinition-ereferral-encounter.html](StructureDefinition-ereferral-encounter.html) |
| ERefPatient | Patient profile coverage | [StructureDefinition-ereferral-patient.html](StructureDefinition-ereferral-patient.html) |
| PH eReferral PractitionerRole | Referring practitioner/facility role | [StructureDefinition-ereferral-practitioner-role.html](StructureDefinition-ereferral-practitioner-role.html) |
| EReferral Provenance | Audit and signature support | [StructureDefinition-ereferral-provenance.html](StructureDefinition-ereferral-provenance.html) |
| EReferral MedicationAdministration | Optional clinical summary support | [StructureDefinition-ereferral-medication-administration.html](StructureDefinition-ereferral-medication-administration.html) |
| ERefImmunization | Optional clinical summary support | [StructureDefinition-ereferral-immunization.html](StructureDefinition-ereferral-immunization.html) |
| EReferral DiagnosticReport | Optional diagnostic report and attachment support | [StructureDefinition-ereferral-diagnostic-report.html](StructureDefinition-ereferral-diagnostic-report.html) |

## Example Coverage

| Example group | Required for minimum path | Notes |
|---------------|---------------------------|-------|
| ServiceRequest referral fixture | Yes | Primary referral request. |
| Task requested, accepted, completed fixtures | Yes | Minimum workflow state progression. |
| Patient, practitioner, practitioner role, referring facility, receiving facility | Yes | Actor and organization context. |
| Condition and observations | Yes | Clinical reason and supporting information. |
| Encounter | Yes | Close step context. |
| Provenance | Optional | Audit trail and signature support. |
| MedicationAdministration and Immunization | Optional | Additional clinical summary examples. |

## Gaps and Deferred Coverage

- No automated create/send/receive/respond/close scenario script is present.
- No multi-server exchange harness is present.
- Rejected, referred-onward, and explicit received response states are pending review.
- Non-response and SLA escalation are deferred.
- Back-referral is not part of the v0.1 minimum connectathon path.
