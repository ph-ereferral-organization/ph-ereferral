Instance: ExampleERefConditionChestPain
InstanceOf: ERefCondition
Usage: #example
Title: "Example Condition - Chest Pain"
Description: "Example chest pain condition for referral"
* clinicalStatus = $condition-clinical#active
* verificationStatus = $condition-ver-status#provisional "Provisional"
* category = $condition-category#encounter-diagnosis "Encounter Diagnosis"
* severity = $sct#24484000 "Severe"
* code = $sct#29857009 "Chest pain"
  * text = "Chest pain on exertion"
* subject = Reference(ExampleERefPatient)
* onsetDateTime = "2025-03-12T08:00:00+08:00"
* recordedDate = "2025-03-15T09:10:00+08:00"
* note.text = "Patient reports exertional chest pain for 3 days with abnormal ECG findings."
