# v0.1 Decision Log and ADR Status

This page records the decision status relevant to the v0.1 connectathon readiness guide. It is not a full architectural decision record system; it identifies accepted, provisional, and pending decisions that affect testing.

## Decision Summary

| ID | Decision area | Current status | Decision or working assumption | Reference |
|----|---------------|----------------|--------------------------------|-----------|
| D-001 | FHIR version | Accepted for v0.1 | v0.1 uses FHIR R4 `4.0.1`. | `sushi-config.yaml` |
| D-002 | PH Core dependency | Provisional | The IG depends on `fhir.ph.core: dev`. Local builds may fall back to a cached concrete/current PH Core package if `dev` is not available. | `sushi-config.yaml` |
| D-003 | Minimum referral request | Accepted for v0.1 testing | ServiceRequest is the primary referral request artifact and Task tracks workflow state. | [EReferral ServiceRequest](StructureDefinition-ereferral-service-request.html), [EReferral Task](StructureDefinition-ereferral-task.html) |
| D-004 | Minimum by-hand workflow | Accepted for v0.1 testing | The connectathon smoke test uses create, send, receive, respond, and close steps. | [Connectathon readiness guide](connectathon-readiness.html) |
| D-005 | Receiving-facility response states | Pending review | Current fixtures support requested, accepted, and completed. Richer received, accepted, rejected, and referred-onward semantics are under review. | Issue [#47](https://github.com/ph-ereferral-organization/ph-ereferral/issues/47), PR [#84](https://github.com/ph-ereferral-organization/ph-ereferral/pull/84) |
| D-006 | Non-response and SLA handling | Deferred | Non-response is out of scope until timing and escalation rules are formally defined. | Issue [#47](https://github.com/ph-ereferral-organization/ph-ereferral/issues/47) |
| D-007 | Versioned release deployment | Pending | No formal versioned v0.1 release URL or tag is available yet. | Issue [#73](https://github.com/ph-ereferral-organization/ph-ereferral/issues/73) |
| D-008 | Back-referral | Deferred for this test pack | Back-referral is policy-relevant but is not included in the v0.1 minimum connectathon path. | [WHO SMART L1 Basis](who-smart-l1.html) |

## ADR Status

Formal ADR files are not yet present in this repository. Until ADR files are added, this page should be used as the release-readiness decision index for the v0.1 test pack.

Before tagging a release candidate, reviewers should either:

- confirm that this decision summary is sufficient for v0.1, or
- create formal ADR files and replace the provisional entries with links to those ADRs.
