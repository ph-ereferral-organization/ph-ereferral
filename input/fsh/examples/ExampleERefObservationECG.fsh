Instance: ExampleERefObservationECG
InstanceOf: PHCoreObservation
Usage: #example
Title: "Example ECG Observation"
Description: "Example ECG findings for referral"
* status = #final
* category = $observation-category#procedure
* code = $loinc#11524-6 "EKG study"
* subject = Reference(ExampleERefPatient)
* effectiveDateTime = "2025-03-15T09:20:00+08:00"
* valueString = "ST depression in leads V4-V6, T wave inversion in lead III"
* interpretation = $v3-ObservationInterpretation#A "Abnormal"
