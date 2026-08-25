Profile: ERefServiceRequest
Parent: PHCoreServiceRequest
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
* requester insert ObligationRequired
* requester only Reference(ERefPractitionerRole)

// TDG Row REF-3: "Date & Time of Signature" - Audit trail via Provenance (linked via relevantHistory)
// TDG Row REF-4: "Professional Signature" - Audit trail via Provenance
* relevantHistory MS
  * ^short = "Referral audit trail"
  * ^definition = "References to Provenance records that track changes and signatures for the referral."
* relevantHistory insert ObligationOptional
* relevantHistory only Reference(ERefProvenance)



// TDG Row REF-9: "Care Navigator" -> ServiceRequest.performer via PractitionerRole (receiving side)
// TDG Row REF-10: "Receiving Facility Name" -> ServiceRequest.performer -> PractitionerRole.organization.display
// TDG Row REF-11: "Receiving Facility NHFR Code" -> ServiceRequest.performer -> PractitionerRole.organization.identifier
* performer MS
* performer insert ObligationOptional
* performer only Reference(PHCoreOrganization or ERefPractitionerRole)
  * ^short = "Receiving facility or practitioner"
  * ^definition = "The facility or practitioner expected to perform the service. For eReferral, this is typically the receiving healthcare facility."

* replaces only Reference(ERefServiceRequest)

// TDG Row REF-13: "Date of Referral" - When the referral was authored
* authoredOn MS
  * ^short = "When the referral was authored"
  * ^definition = "The date and time when the referral request was created."
* authoredOn insert ObligationOptional


// TDG Row REF-14: "Referral Category" - Urgency and setting (emergency vs outpatient/routine)
* category MS
* category insert ObligationOptional
* category from EReferralServiceCategory (required)
  * ^short = "Referral Category - Urgency and setting"
  * ^definition = "Referral Category - Urgency and setting (emergency vs outpatient/routine)"

* intent MS
* intent insert ObligationOptional
* intent = #order (exactly)
  * ^short = "Intent is always 'order' for referrals"
  * ^definition = "eReferrals are always orders for services to be performed by the receiving facility."

// TDG Row REF-15: "Time Called" - When the service is needed (optional)
// Also covers supporting clinical information (Clinical Summary elements)
* occurrence[x] MS
  * ^short = "When the service is needed"
  * ^definition = "The date/time or period when the service should be performed."
* occurrence[x] insert ObligationOptional

* supportingInfo only Reference(ERefCondition or ERefObservation or ERefProcedure or ERefMedicationAdministration or ERefImmunization)

// TDG Row REF-16: "Reason for Referral (service type)" - Clinical reason for the referral
// TERMINOLOGY: for review
* reasonCode MS
* reasonCode insert ObligationOptional
* reasonCode from EReferralReason (required)
  * ^short = "Reason for referral"
  * ^definition = "The clinical reason for the referral, describing why the service is being requested."

// TDG Row REF-16: Supporting clinical information (conditions, observations)
* reasonReference MS
* reasonReference insert ObligationOptional

* reasonReference only Reference(ERefCondition or ERefObservation)

// TDG Row REF-21: "Patient Full Name" (and related patient demographics)
* subject MS
* subject insert ObligationOptional
* subject only Reference(ERefPatient)

* encounter MS
* encounter insert ObligationOptional
* encounter only Reference(ERefEncounter)

// Free-text notes from referring practitioner (no specific TDG row)
* note MS
* note insert ObligationOptional




// --- Invariants ---
// TDG: for discussion
* obeys ereferral-requester-has-role

Invariant: ereferral-requester-has-role
Description: "The requester should reference a PractitionerRole when referring facility information is available"
Severity: #warning
Expression: "requester.resolve().ofType(PractitionerRole).exists() implies requester.resolve().ofType(PractitionerRole).organization.exists()"
