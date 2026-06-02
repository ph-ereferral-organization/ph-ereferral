Profile: ERefMedicationAdministration
Parent: PHCoreMedicationAdministration
Id: ereferral-medication-administration
Title: "EReferral MedicationAdministration"
Description: "Profile for medications administered to patients in the Philippine eReferral context. Captures medications given as part of treatment (REF-39) and referenced via ServiceRequest.supportingInfo (REF-15) to provide clinical context for referrals."

// TDG Row REF-39: "Treatment Given" - Stabilization procedures/meds
// TDG Row REF-15: Referenced via ServiceRequest.supportingInfo for clinical context
// All reference constraints inherited from PHCoreMedicationAdministration:
// - subject: PHCorePatient | Group
// - context: PHCoreEncounter | EpisodeOfCare
// - performer.actor: PHCorePractitioner | PHCorePractitionerRole | PHCorePatient | PHCoreRelatedPerson | Device
// - request: PHCoreMedicationRequest
// - reasonReference: Condition | PHCoreObservation | DiagnosticReport
// - partOf: PHCoreMedicationAdministration | PHCoreProcedure

// Must Support elements for eReferral clinical context
* status 1..1 MS
* insert ObligationRequired

* status ^short = "Medication administration status"
* status ^definition = "The status of the medication administration. Tracks whether the medication was completed, in-progress, or not administered."

* medication[x] 1..1 MS
* insert ObligationRequired

* medication[x] ^short = "Medication administered"
* medication[x] ^definition = "The medication that was administered to the patient. Can be a reference to a Medication resource or a coded concept."

* subject 1..1 MS
* insert ObligationRequired

* subject ^short = "Patient receiving medication"
* subject ^definition = "The patient who received the medication. Constrained to PHCorePatient."

* effective[x] 1..1 MS
* insert ObligationRequired

* effective[x] ^short = "When medication was administered"
* effective[x] ^definition = "The date/time or period when the medication administration occurred."
