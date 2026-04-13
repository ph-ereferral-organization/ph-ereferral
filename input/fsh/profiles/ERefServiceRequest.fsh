Profile: ERefServiceRequest
Parent: ServiceRequest
Id: ereferral-service-request
Title: "EReferral ServiceRequest"
Description: "Profile for ServiceRequest resource in the Philippine eReferral context. This profile defines the core referral request structure for referring patients between healthcare facilities."
// Must Support Elements - arranged by TDG Row sequence (REF-1 to REF-21)

// TDG Row REF-1: "Name of Referring Practitioner" -> ServiceRequest.requester via PractitionerRole -> Practitioner
// TDG Row REF-2: "Practitioner Role" -> ServiceRequest.requester via PractitionerRole.code
// TDG Row REF-5: "Initiating Facility Name" -> ServiceRequest.requester (via PractitionerRole's Organization)
// TDG Row REF-6: "Initiating Facility NHFR Code" -> ServiceRequest.requester (via PractitionerRole's Organization.identifier)
// TDG Row REF-7: "Initiating Facility Address" -> ServiceRequest.requester (via PractitionerRole's Organization.address)
// TDG Row REF-8: "Initiating Facility Contact Number" -> ServiceRequest.requester (via PractitionerRole's Organization.telecom)
* requester 1..1 MS
* requester only Reference(PHCorePractitionerRole)
  * ^short = "Referring practitioner"
  * ^definition = "The practitioner requesting the referral service. Uses PractitionerRole to capture both the practitioner and their facility/organization context."

// TDG Row REF-3: "Date & Time of Signature" - Audit trail via Provenance (linked via relevantHistory)
// TDG Row REF-4: "Professional Signature" - Audit trail via Provenance
* relevantHistory MS
  * ^short = "Referral audit trail"
  * ^definition = "References to Provenance records that track changes and signatures for the referral."

// TDG Row REF-9: "Care Navigator" -> ServiceRequest.performer via PractitionerRole (receiving side)
// TDG Row REF-10: "Receiving Facility Name" -> ServiceRequest.performer -> PractitionerRole.organization.display
// TDG Row REF-11: "Receiving Facility NHFR Code" -> ServiceRequest.performer -> PractitionerRole.organization.identifier
* performer MS
* performer only Reference(PHCoreOrganization or PHCorePractitionerRole)
  * ^short = "Receiving facility or practitioner"
  * ^definition = "The facility or practitioner expected to perform the service. For eReferral, this is typically the receiving healthcare facility."

// TDG Row REF-13: "Date of Referral" - When the referral was authored
* authoredOn MS
  * ^short = "When the referral was authored"
  * ^definition = "The date and time when the referral request was created."

// TDG Row REF-14: "Referral Category" - Urgency and setting (emergency vs outpatient/routine)
* category MS
* category from EReferralServiceCategory (extensible)
  * ^short = "Type of referral service requested"
  * ^definition = "Categorizes the type of referral (e.g., consultation, procedure, diagnostic imaging, laboratory)."

// TDG Row REF-14: "Referral Category" - Urgency/priority of the referral
// Uses standard FHIR RequestPriority: routine | urgent | emergent | stat
// NOTE: ASAP (as soon as possible) is not used in the Philippine eReferral context per TDG requirements.
// TERMINOLOGY: for terminology validation
* priority MS
* priority from EReferralPriority (required)
  * ^short = "Urgency/priority of the referral"
  * ^definition = "Indicates how quickly the referral should be acted upon (routine, urgent, emergent)."

// TDG Row REF-14: "Referral Category" - Intent is always 'order' for referrals (workflow trigger)
* intent MS
* intent = #order (exactly)
  * ^short = "Intent is always 'order' for referrals"
  * ^definition = "eReferrals are always orders for services to be performed by the receiving facility."

// TDG Row REF-15: "Time Called" - When the service is needed (optional)
// Also covers supporting clinical information (Clinical Summary elements)
* occurrence[x] MS
  * ^short = "When the service is needed"
  * ^definition = "The date/time or period when the service should be performed."

// TDG Row REF-15: "Time Called" and other supporting clinical information
// Clinical Summary elements: Conditions, Observations, Procedures, Medications, Immunizations
* supportingInfo MS
* supportingInfo only Reference(PHCoreCondition or PHCoreObservation or PHCoreProcedure or PHCoreMedicationAdministration or PHCoreImmunization)
  * ^short = "Additional clinical information"
  * ^definition = "Additional clinical information relevant to the referral, such as relevant conditions, procedures, medications, immunizations, or observations."

// TDG Row REF-16: "Reason for Referral (service type)" - Classification of requested service
* code MS

// TDG Row REF-16: "Reason for Referral (service type)" - Clinical reason for the referral
// TERMINOLOGY: for review
* reasonCode MS
* reasonCode from EReferralReason (example)
  * ^short = "Reason for referral"
  * ^definition = "The clinical reason for the referral, describing why the service is being requested."

// TDG Row REF-16: Supporting clinical information (conditions, observations)
* reasonReference MS
* reasonReference only Reference(PHCoreCondition or PHCoreObservation)
  * ^short = "Conditions or observations supporting referral"
  * ^definition = "References to clinical conditions or observations that justify the need for the referral."

// TDG Row REF-21: "Patient Full Name" (and related patient demographics)
* subject MS
* subject only Reference(PHCorePatient)
  * ^short = "Patient being referred"
  * ^definition = "The patient who is the subject of the referral request."

// TDG Row REF-1, REF-2, REF-5-11: Requester/Performer tracking
* status MS
  * ^short = "Referral status"
  * ^definition = "The status of the referral request. Tracks the lifecycle of the referral from draft to completed."

// Free-text notes from referring practitioner (no specific TDG row)
* note MS
  * ^short = "Additional notes or instructions"
  * ^definition = "Free-text notes or instructions from the referring practitioner to the receiving facility."

// Requisition ID - for tracking/grouping related referrals (no specific TDG row)
* requisition MS
  * ^short = "Referral identifier"
  * ^definition = "A shared identifier common to all referral requests that were authorized more or less simultaneously. Used for grouping related referrals."

// --- Invariants ---
// TDG: for discussion
* obeys ereferral-requester-has-role

Invariant: ereferral-requester-has-role
Description: "The requester should reference a PractitionerRole when referring facility information is available"
Severity: #warning
Expression: "requester.resolve().ofType(PractitionerRole).exists() implies requester.resolve().ofType(PractitionerRole).organization.exists()"
