# Referral Workflow and Receiving-Facility Response

This page documents the v0.1 interpretation used by this IG for the receiving-facility response after a referral is sent. It is based on the current project analysis for Issue #41, the related response-state clarification in Issue #47, and the workflow narrative request in Issue #80.

## Scope

The v0.1 flow covers the minimum path needed for early implementation and testing:

1. The referring facility creates and sends an `ERefServiceRequest`.
2. An `ERefTask` tracks the workflow for that request.
3. The receiving facility acknowledges, evaluates, and responds.
4. The response is represented as received, accepted, rejected, or referred onward.
5. The task is closed when the outcome is known.

Back-referral, formal service-level timing rules, and non-response escalation are deferred unless a later project decision brings them into scope.

## Response Semantics

`Task.status` remains the standard FHIR lifecycle status. `Task.businessStatus` carries the eReferral response term that implementers need to exchange and display.

| Receiving response | FHIR representation | Interpretation |
|--------------------|---------------------|----------------|
| Received | `Task.status = received`, `Task.businessStatus = received` | The receiving facility has acknowledged receipt and is reviewing the referral. |
| Accepted | `Task.status = accepted`, `Task.businessStatus = accepted` | The receiving facility can take the case and gives a positive transfer or service response. |
| Rejected | `Task.status = rejected`, `Task.businessStatus = rejected` | The receiving facility cannot take the case and no onward facility is identified in the same response. |
| Referred onward | `Task.status = rejected`, `Task.businessStatus = referred-onward` | The first receiving facility cannot take the case but identifies another facility for transfer or referral. |

For a referred-onward response, the rejecting facility's task can carry a coded `output` indicating that an onward referral request was created. The onward `ERefServiceRequest` uses `ServiceRequest.replaces` to link back to the prior request when that request is known to the system.

## AO 2020-0019 Interpretation

AO 2020-0019 Annex C supports a positive receiving response, a capacity-full response that points to another facility, and other instructions. Annex D includes action points for received and referred. This IG therefore treats `received`, `accepted`, and `referred-onward` as policy-aligned response concepts.

The term `rejected` is retained only as a FHIR workflow state and local implementation term for the case where a receiving facility cannot take the case and no onward facility is specified. It should not be read as a separate AO-defined action unless the project later confirms that wording.

Non-response is not modeled as a receiving-facility response in v0.1. Until the project defines timing and escalation rules, systems should leave the task in the last known state, commonly `requested` or `received`, and manage timeout handling outside this profile.

## Examples

The following examples show the response states:

| Example | Purpose |
|---------|---------|
| [ExampleERefTaskReceived](Task-ExampleERefTaskReceived.html) | Referral receipt acknowledged and under review. |
| [ExampleERefTaskAccepted](Task-ExampleERefTaskAccepted.html) | Receiving facility accepts the case. |
| [ExampleERefTaskRejected](Task-ExampleERefTaskRejected.html) | Receiving facility cannot take the case, with no onward facility identified. |
| [ExampleERefTaskReferredOnward](Task-ExampleERefTaskReferredOnward.html) | Receiving facility cannot take the case and identifies another facility. |
| [ExampleERefServiceRequestOnward](ServiceRequest-ExampleERefServiceRequestOnward.html) | Onward referral request linked to the prior request using `ServiceRequest.replaces`. |

The profile support for this flow is defined in [EReferral Task](StructureDefinition-ereferral-task.html) and [EReferral ServiceRequest](StructureDefinition-ereferral-service-request.html).
