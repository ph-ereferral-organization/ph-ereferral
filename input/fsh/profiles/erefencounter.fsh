Profile: ERefEncounter
Parent: PHCoreEncounter
Id: ereferral-encounter
Title: "ERefEncounter"
Description: "Encounter profile for the Philippine eReferral system. Extends PHCoreEncounter to capture the clinical encounter context associated with a referral, including encounter status, classification, participants, and clinical information relevant to the referral workflow."

* ^status = #draft
* ^experimental = true
* ^purpose = "To standardize encounter information within the Philippine eReferral system, ensuring clinical context is consistently captured and linked to referral requests."

* subject only Reference(ERefPatient)
  * ^short = "The referral patient present at the encounter."
  * ^definition = "The referral patient who is the subject of this encounter."
* basedOn only Reference(ERefServiceRequest)
* reasonReference only Reference(PHCoreCondition or PHCoreObservation or PHCoreProcedure)
//* reasonReference only Reference(ERefCondition or ERefObservation or ERefProcedure)  TO DO - Rationale: ERef Profiles still unavailable.
  * ^definition = "Reason the encounter takes place, expressed as a reference to a Condition, Observation, or Procedure."
