Profile: ERefMedicationAdministration
Parent: PHCoreMedicationAdministration
Id: ereferral-medication-administration
Title: "EReferral MedicationAdministration"
Description: "Profile for medications administered to patients in the Philippine eReferral context. Captures medications given as part of treatment (REF-39). Linked to the encounter via MedicationAdministration.context for clinical context."

// TDG Row REF-39: "Treatment Given" - Stabilization procedures/meds
// Linked to encounter via MedicationAdministration.context for clinical context
// All reference constraints inherited from PHCoreMedicationAdministration:
// - subject: PHCorePatient | Group
// - context: PHCoreEncounter | EpisodeOfCare
// - performer.actor: PHCorePractitioner | PHCorePractitionerRole | PHCorePatient | PHCoreRelatedPerson | Device
// - request: PHCoreMedicationRequest
// - reasonReference: Condition | ERefObservation | DiagnosticReport
// - partOf: PHCoreMedicationAdministration | PHCoreProcedure

// Must Support elements for eReferral clinical context
* status MS
* status insert ObligationRequired

* medication[x] MS
* medication[x] insert ObligationRequired


* subject MS
* subject insert ObligationRequired
* subject only Reference(ERefPatient)

* context MS
* context insert ObligationOptional
* context only Reference(ERefEncounter)

* effective[x] MS
* effective[x] insert ObligationRequired