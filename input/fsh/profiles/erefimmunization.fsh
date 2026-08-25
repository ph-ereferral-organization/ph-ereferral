Profile: ERefImmunization
Parent: PHCoreImmunization
Id: ereferral-immunization
Title: "ERefImmunization"
Description: "Immunization profile for the Philippine eReferral system. Extends PHCoreImmunization to define must-support elements for referral clinical context. Immunization records are linked to the encounter via Immunization.encounter to provide supporting clinical information about a patient's vaccination history."

* status MS
* status insert ObligationRequired

* vaccineCode
// * vaccineCode from PlaceholderValueSet
* patient MS
* patient insert ObligationRequired

* patient only Reference(ERefPatient)
* occurrence[x] MS  
* occurrence[x] insert ObligationRequired

