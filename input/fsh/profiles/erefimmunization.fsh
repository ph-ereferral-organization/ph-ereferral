Profile: ERefImmunization
Parent: PHCoreImmunization
Id: ereferral-immunization
Title: "ERefImmunization"
Description: "Immunization profile for the Philippine eReferral system. Extends PHCoreImmunization to define must-support elements for referral clinical context. Immunization records are referenced via ServiceRequest.supportingInfo to provide supporting clinical information about a patient's vaccination history."

* ^status = #draft
* ^experimental = true
* ^purpose = "To standardize immunization records included as supporting clinical information in Philippine eReferrals, ensuring key vaccination details are consistently captured and exchanged between referring and receiving facilities."

* status 1..1 MS
* vaccineCode 1..1
* vaccineCode ^short = "Vaccine product administered"
* vaccineCode ^definition = "Vaccine that was administered or was to be administered. Supports CVX, ICD-11, or locally defined Philippine vaccine codes."
// * vaccineCode from PlaceholderValueSet
* patient 1..1 MS
* patient only Reference(ERefPatient)
* patient ^short = "Patient who was immunized"
* occurrence[x] 1..1 MS  
