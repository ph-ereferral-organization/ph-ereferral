Instance: ExampleERefConditionHypertensiveEmergency
InstanceOf: ERefCondition
Usage: #example
Title: "Example Condition - Hypertensive Emergency"
Description: "Example hypertensive emergency condition used as a clinical reason for referral."
* clinicalStatus = $condition-clinical#active
* verificationStatus = $condition-ver-status#confirmed "Confirmed"
* category = $condition-category#encounter-diagnosis "Encounter Diagnosis"
* severity = $sct#24484000 "Severe"
* code = $sct#132721000119104 "Hypertensive emergency"
  * text = "Hypertensive emergency with suspected acute end-organ damage"
* subject = Reference(ExampleERefPatient)
* onsetDateTime = "2025-03-15T07:45:00+08:00"
* recordedDate = "2025-03-15T08:05:00+08:00"
* note.text = "Blood pressure remained above 180/120 mmHg with severe headache and visual symptoms. Referred for emergency evaluation and management."
