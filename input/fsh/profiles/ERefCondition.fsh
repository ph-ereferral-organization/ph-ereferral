Profile: ERefCondition
Parent: PHCoreCondition
Id: ereferral-condition
Title: "EReferral Condition"
Description: "Condition profile for diagnoses, problems, or clinical conditions relevant to a Philippine eReferral request."

// TDG Row REF-16: Clinical reason for referral via ServiceRequest.reasonReference
// Clinical context linked via Condition.encounter Reference(PHeRefEncounter)
// PH Core Condition constraints and terminology are inherited unless explicitly profiled below.


* subject MS
* subject insert ObligationOptional
* subject only Reference(ERefPatient)

* encounter MS
* encounter insert ObligationOptional
* encounter only Reference(ERefEncounter)


// TDG REF-31	Chief Complaint	Presenting complaint
* category MS
  * ^definition = "Chief complaint: problem-list-item | Working Impression: encounter-diagnosis"
* category insert ObligationOptional

// TDG REF-32	Clinical History
* note MS
* note insert ObligationOptional
