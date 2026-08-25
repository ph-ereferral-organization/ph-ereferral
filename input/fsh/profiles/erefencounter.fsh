Profile: ERefEncounter
Parent: PHCoreEncounter
Id: ereferral-encounter
Title: "ERefEncounter"
Description: "Encounter profile for the Philippine eReferral system. Extends PHCoreEncounter to capture the clinical encounter context associated with a referral, including encounter status, classification, participants, and clinical information relevant to the referral workflow."

* subject only Reference(ERefPatient)

// TDG for Receiving Facility
* basedOn only Reference(ERefServiceRequest)


* reasonReference only Reference(ERefCondition or ERefObservation or ERefProcedure)