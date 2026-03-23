ValueSet: EReferralServiceCategory
Id: ereferral-service-category
Title: "eReferral Service Category"
Description: "Categories of services that can be requested through eReferral"
* ^status = #draft
* ^experimental = true
* $sct#108252007 "Laboratory procedure"
* $sct#363679005 "Imaging"
* $sct#409063005 "Counselling"
* $sct#409073007 "Education"
* $sct#387713003 "Surgical procedure"

ValueSet: EReferralPriority
Id: ereferral-priority
Title: "eReferral Priority"
Description: "Priority levels for eReferral requests. Uses standard FHIR RequestPriority values."
* ^status = #draft
* ^experimental = true
* $request-priority#routine "Routine"
* $request-priority#urgent "Urgent"
* $request-priority#stat "STAT"

ValueSet: EReferralReason
Id: ereferral-reason
Title: "eReferral Reason"
Description: "Clinical reasons for eReferral requests. Uses SNOMED CT clinical findings and diagnoses."
* ^experimental = true
* ^status = #draft
* $sct#267036007 "Dyspnea"
* $sct#29857009 "Chest pain"
* $sct#414545008 "Suspected lung cancer"
* $sct#42343007 "Congestive heart failure"
* $sct#49436004 "Atrial fibrillation"
* $sct#59621000 "Essential hypertension"
* $sct#73211009 "Diabetes mellitus"
* $sct#109006 "Anxiety disorder"
