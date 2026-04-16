Profile: ERefTask
Parent: PHCoreTask
Id: ereferral-task
Title: "EReferral Task"
Description: "Task profile for Philippine eReferral workflow management. Tracks referral state transitions from request through completion, supporting workflow coordination between sending and receiving facilities."

// TDG Row REF-9: "Care Navigator" -> Task.owner / Task.requester for task assignment

// =============================================================================
// Elements NOT in PH Core OR need MS level-up per TDG requirements
// Following Constraint Decision Logic:
// - Rule 1: Inherit from PH Core (never duplicate)
// - Rule 2: Level up to MS only (unless TDG specifies different cardinality)
// - Rule 3: Add new elements with MS when not in PH Core
// =============================================================================

// -----------------------------------------------------------------------------
// intent: PH Core has 1..1 (NOT MS), TDG requires 1..1 MS
// Action: Add MS flag + fix to #order for referral workflows
// -----------------------------------------------------------------------------
* intent MS
* intent = #order (exactly)
* intent ^short = "Fixed to 'order' for referrals"
* intent ^definition = "The intent is fixed to 'order' as eReferral tasks represent actionable orders for services to be performed by receiving facilities."

// -----------------------------------------------------------------------------
// focus: PH Core has 0..1 (NOT MS), TDG requires 1..1 MS
// Action: Change cardinality + add MS (TDG business requirement)
// -----------------------------------------------------------------------------
* focus 1..1 MS
* focus only Reference(ERefServiceRequest)
* focus ^short = "Reference to the ServiceRequest being tracked"
* focus ^definition = "The ServiceRequest that this task is tracking through the eReferral workflow. Required for all eReferral tasks."

// -----------------------------------------------------------------------------
// requester: PH Core has 0..1 (NOT MS), TDG requires 1..1 MS
// Action: Change cardinality + add MS (TDG business requirement)
// -----------------------------------------------------------------------------
* requester 1..1 MS
* requester only Reference(PHCorePractitioner or PHCorePractitionerRole or PHCoreOrganization)
* requester ^short = "Requesting practitioner or facility"
* requester ^definition = "The practitioner or facility that created the referral task. Represents the initiating side of the eReferral workflow."

// -----------------------------------------------------------------------------
// owner: PH Core has 0..1 (NOT MS), TDG requires 0..1 MS
// Action: Add MS only (keep 0..1 cardinality)
// -----------------------------------------------------------------------------
* owner MS
* owner only Reference(PHCorePractitioner or PHCorePractitionerRole or PHCoreOrganization)
* owner ^short = "Assigned care navigator or receiving facility"
* owner ^definition = "The practitioner, care navigator, or facility responsible for executing the referral task. TDG REF-9: 'Care Navigator' assignment."

// -----------------------------------------------------------------------------
// authoredOn: PH Core has 0..1 (NOT MS), TDG requires 0..1 MS
// Action: Add MS only (keep 0..1 cardinality)
// -----------------------------------------------------------------------------
* authoredOn MS
* authoredOn ^short = "When task was created"
* authoredOn ^definition = "The date and time when the eReferral task was created."

// -----------------------------------------------------------------------------
// lastModified: PH Core has 0..1 (NOT MS), TDG requires 0..1 MS
// Action: Add MS only (keep 0..1 cardinality)
// -----------------------------------------------------------------------------
* lastModified MS
* lastModified ^short = "When task was last updated"
* lastModified ^definition = "The date and time when the eReferral task was last modified."

// =============================================================================
// Elements INHERITED from PH Core (do not redeclare):
// - status: 1..1 MS (already constrained in PH Core)
// - code: 0..1 MS (already constrained in PH Core)
// - for: 0..1 MS → Reference(PHCorePatient) (already constrained in PH Core)
// - executionPeriod: 0..1 MS (already constrained in PH Core)
// =============================================================================

// =============================================================================
// eReferral-Specific Invariants
// =============================================================================

// Ensure task references a ServiceRequest (enforced by focus cardinality 1..1,
// but this provides a clear error message and FHIRPath validation)
Invariant: ereferral-task-has-request
Description: "Task must reference a ServiceRequest (enforced by focus 1..1)"
Severity: #error
Expression: "focus.exists()"

// Additional validation for eReferral-specific status transitions
Invariant: ereferral-task-status-valid
Description: "Status must be a valid eReferral workflow state"
Severity: #warning
Expression: "status in ('draft' | 'requested' | 'received' | 'accepted' | 'rejected' | 'ready' | 'in-progress' | 'on-hold' | 'completed' | 'cancelled')"
