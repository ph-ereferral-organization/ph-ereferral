Profile: ERefCondition
Parent: PHCoreCondition
Id: ereferral-condition
Title: "EReferral Condition"
Description: "Condition profile for diagnoses, problems, or clinical conditions relevant to a Philippine eReferral request."

// TDG Row REF-16: Clinical reason for referral via ServiceRequest.reasonReference
// TDG Row REF-15: Clinical summary support via ServiceRequest.supportingInfo
// PH Core Condition constraints and terminology are inherited unless explicitly profiled below.

* clinicalStatus MS
  * ^short = "Clinical status of the condition"
  * ^definition = "The current clinical status of the diagnosis, problem, or condition relevant to the referral."

* verificationStatus MS
  * ^short = "Verification status of the condition"
  * ^definition = "The certainty or verification state for the diagnosis, problem, or condition, such as provisional or confirmed."

* category MS
  * ^short = "Condition category"
  * ^definition = "Categorizes the condition as a problem list item, encounter diagnosis, or other category supported by the inherited PH Core binding."

* code MS
  * ^short = "Diagnosis, problem, or condition"
  * ^definition = "The coded diagnosis, problem, symptom, or clinical condition that is relevant to the eReferral request."

* subject MS
  * ^short = "Patient with the condition"
  * ^definition = "The patient who has the diagnosis, problem, or clinical condition relevant to the referral."

* onset[x] MS
  * ^short = "Condition onset"
  * ^definition = "The estimated or known date, date/time, age, period, range, or text describing when the condition began."

* recordedDate MS
  * ^short = "Date condition was recorded"
  * ^definition = "The date when the condition was first recorded in the referring facility's clinical record."

* note MS
  * ^short = "Condition notes"
  * ^definition = "Additional clinical notes about the condition that may support referral assessment or triage."
