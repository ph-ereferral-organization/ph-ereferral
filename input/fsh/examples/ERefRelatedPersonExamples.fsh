Instance: ExampleERefRelatedPersonNextOfKin
InstanceOf: ERefRelatedPerson
Usage: #example
Title: "Example ERefRelatedPerson - Next of Kin"
Description: "Roberto Reyes, husband and next-of-kin for Ana Reyes."

* active = true
* patient = Reference(ExampleERefPatient)
* relationship[0] = $v3-roleCode#NOK "next of kin"
* relationship[+] = $v3-roleCode#HUSB "husband"
* name.use = #official
* name.family = "Reyes"
* name.given[0] = "Roberto"
* telecom[0].system = #phone
* telecom[0].value = "+639189876543"
* telecom[0].use = #mobile

Instance: ExampleERefRelatedPersonAccompanying
InstanceOf: ERefRelatedPerson
Usage: #example
Title: "Example ERefRelatedPerson - Accompanying Person"
Description: "Maria Reyes, mother of Ana Reyes, accompanying her during the referral."

* active = true
* patient = Reference(ExampleERefPatient)
* relationship[0] = $v3-roleCode#ECON "emergency contact"
* relationship[+] = $v3-roleCode#MTH "mother"
* name.use = #official
* name.family = "Reyes"
* name.given[0] = "Maria"
* telecom[0].system = #phone
* telecom[0].value = "+639171112222"
* telecom[0].use = #mobile
