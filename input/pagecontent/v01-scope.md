# v0.1 Scope and Release Notes

This page records the draft release scope, deferred items, and release-note content used by the v0.1 connectathon readiness guide.

## v0.1 Scope Statement

PH eReferral IG v0.1 defines a minimum FHIR R4 referral path for testing an electronic referral from an initiating facility to a receiving facility. The minimum path uses ServiceRequest for the referral request and Task for workflow state tracking, with supporting Patient, PractitionerRole, Organization, Condition, Observation, Encounter, Provenance, MedicationAdministration, and Immunization examples where available.

v0.1 is a draft testing baseline. It is not a production deployment specification.

## In-Scope Artifacts

| Artifact type | In-scope v0.1 content |
|---------------|-----------------------|
| Core referral request | [EReferral ServiceRequest](StructureDefinition-ereferral-service-request.html) |
| Workflow tracking | [EReferral Task](StructureDefinition-ereferral-task.html) |
| Encounter context | [ERefEncounter](StructureDefinition-ereferral-encounter.html) |
| Patient | [ERefPatient](StructureDefinition-ereferral-patient.html) and PH Core Patient examples |
| Practitioner role | [PH eReferral PractitionerRole](StructureDefinition-ereferral-practitioner-role.html) |
| Provenance | [EReferral Provenance](StructureDefinition-ereferral-provenance.html) |
| Medication support | [EReferral MedicationAdministration](StructureDefinition-ereferral-medication-administration.html) |
| Immunization support | [ERefImmunization](StructureDefinition-ereferral-immunization.html) |
| Referral terminology | [eReferral Service Category](ValueSet-ereferral-service-category.html), [eReferral Priority](ValueSet-ereferral-priority.html), and [eReferral Reason](ValueSet-ereferral-reason.html) |
| Test fixtures | Required and optional examples listed in the [connectathon readiness guide](connectathon-readiness.html). |

## Out of Scope or Deferred

| Deferred item | Current v0.1 handling |
|---------------|-----------------------|
| Versioned release publication | Pending issue [#73](https://github.com/ph-ereferral-organization/ph-ereferral/issues/73). |
| Rich receiving-facility response states | Pending review in issue [#47](https://github.com/ph-ereferral-organization/ph-ereferral/issues/47) and PR [#84](https://github.com/ph-ereferral-organization/ph-ereferral/pull/84). |
| Non-response and SLA escalation | Deferred until timing and escalation rules are formally defined. |
| Back-referral | Not included in the v0.1 minimum test path. |
| Multi-server connectathon harness | Not yet available. |
| Attachment exchange and security workflow | Outside the current v0.1 by-hand test. |
| Operational facility directory and HCPN routing | Not fully specified in this v0.1 test pack. |

## Change Log

| Version or build | Status | Notes |
|------------------|--------|-------|
| `0.1.0` / `ci-build` | Draft | Initial connectathon readiness baseline with build instructions, by-hand test path, fixture list, known limitations, and release-readiness references. |

## Release Tag

No formal v0.1 release tag is available yet. When the release management work is complete, link the tagged release from this page and update the [connectathon readiness guide](connectathon-readiness.html).

## Release Candidate Checklist

- Release branch or tag exists and is recorded.
- `sushi .` completes with `0 Errors`.
- Full IG Publisher build completes and `output/qa.html` is reviewed.
- Required test fixtures render and links are valid.
- Connectathon by-hand test evidence is recorded.
- Known limitations are accepted by reviewers or moved to release blockers.
- TDG technical review is complete.
- Product owner release-readiness review is complete.
