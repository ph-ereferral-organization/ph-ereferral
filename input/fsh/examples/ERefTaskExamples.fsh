// =============================================================================
// ERefTask Examples — TDG Mapped Task States
//
// Task states per [CLEAN 20260605] Synchronous TDG FHIR Mapping:
//   REF-17: Action Point: Received → Task.status = received
//   REF-18: Action Point: Referred (Forwarded) → Task.status = rejected +
//           Task.businessStatus = referred-onward
//
// All Task instances share references to the Ana Reyes bundle:
//   - focus → ExampleERefServiceRequest
//   - for → ExampleERefPatient
//   - requester → ExampleERefPractitionerRoleSubmission (KHC)
//   - owner → varies per state (DRSTMH or onward)
//
// Elements minimized to TDG mappings only.
// =============================================================================

// --- TASK — REF-17: Action Point Received --------------------------------------
Instance: ExampleERefTaskReceived
InstanceOf: ERefTask
Usage: #example
Title: "Example eReferral Task — Received"
Description: "Task in 'received' status: DRSTMH has acknowledged the referral."

* status = #received
* intent = #order
* businessStatus = EReferralWorkflowCS#received "Received"
* focus = Reference(ExampleERefServiceRequest)
* for = Reference(ExampleERefPatient)
* requester = Reference(ExampleERefPractitionerRoleSubmission)
* owner = Reference(ExampleERefPractitionerRoleReceiving)
* authoredOn = "2026-06-18T08:30:00+08:00"
* lastModified = "2026-06-18T09:45:00+08:00"


// --- TASK — REF-17/REF-18: Rejected (no onward) ---------------------------------
Instance: ExampleERefTaskRejected
InstanceOf: ERefTask
Usage: #example
Title: "Example eReferral Task — Rejected"
Description: "Task in 'rejected' status: DRSTMH cannot take the case and no onward facility is identified."

* status = #rejected
* intent = #order
* businessStatus = EReferralWorkflowCS#rejected "Rejected"
* focus = Reference(ExampleERefServiceRequest)
* for = Reference(ExampleERefPatient)
* requester = Reference(ExampleERefPractitionerRoleSubmission)
* owner = Reference(ExampleERefPractitionerRoleReceiving)
* authoredOn = "2026-06-18T08:30:00+08:00"
* lastModified = "2026-06-18T10:05:00+08:00"
* statusReason.text = "Receiving facility cannot take the case."


// --- TASK — REF-18: Referred Onward ---------------------------------------------
Instance: ExampleERefTaskReferredOnward
InstanceOf: ERefTask
Usage: #example
Title: "Example eReferral Task — Referred Onward"
Description: "Task in 'rejected' status with 'referred-onward' business status: DRSTMH redirects the case."

* status = #rejected
* intent = #order
* businessStatus = EReferralWorkflowCS#referred-onward "Referred onward"
* focus = Reference(ExampleERefServiceRequest)
* for = Reference(ExampleERefPatient)
* requester = Reference(ExampleERefPractitionerRoleSubmission)
* owner = Reference(ExampleERefPractitionerRoleReceiving)
* authoredOn = "2026-06-18T08:30:00+08:00"
* lastModified = "2026-06-18T12:45:00+08:00"
* statusReason = EReferralWorkflowCS#capacity-full "Capacity full"
