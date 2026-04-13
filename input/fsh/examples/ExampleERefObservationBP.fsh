Instance: ExampleERefObservationBP
InstanceOf: PHCoreObservation
Usage: #example
Title: "Example Blood Pressure Observation"
Description: "Example vital signs for referral"
* status = #final
* category = $observation-category#vital-signs
* code = $loinc#85354-9 "Blood pressure panel with all children optional"
* subject = Reference(ExampleERefPatient)
* effectiveDateTime = "2025-03-15T09:15:00+08:00"
* component[0].code = $loinc#8480-6 "Systolic blood pressure"
* component[=].valueQuantity = 160 'mm[Hg]' "mmHg"
* component[+].code = $loinc#8462-4 "Diastolic blood pressure"
* component[=].valueQuantity = 95 'mm[Hg]' "mmHg"
