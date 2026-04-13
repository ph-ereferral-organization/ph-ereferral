Instance: ExampleERefConditionChestPain
InstanceOf: PHCoreCondition
Usage: #example
Title: "Example Condition - Chest Pain"
Description: "Example chest pain condition for referral"
* clinicalStatus = $condition-clinical#active
* verificationStatus = $sct#provisional "Provisional"
* category = $sct#439401001 "Diagnosis"
* severity = $sct#24484000 "Severe"
* code = $sct#29857009 "Chest pain"
  * text = "Chest pain on exertion"
* subject = Reference(ExampleERefPatient)
* onsetDateTime = "2025-03-12"
