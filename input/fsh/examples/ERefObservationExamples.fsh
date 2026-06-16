// TDG Mapping: Clinical Information Group (REF-31, REF-33-38)
// Observations referenced via ServiceRequest.supportingInfo and ServiceRequest.reasonReference

// =============================================================================
// TDG Row REF-31: Chief Complaint
// =============================================================================
Instance: ExampleERefObservationChiefComplaint
InstanceOf: ERefObservation
Usage: #example
Title: "Example Chief Complaint Observation"
Description: "Example chief complaint for eReferral (REF-31). Referenced via ServiceRequest.reasonReference to provide clinical context for referral."
* status = #final
* category = $observation-category#survey "Survey"
* code = $loinc#10154-3 "Chief complaint"
* code.text = "Chief Complaint"
* subject = Reference(ExampleERefPatient)
* effectiveDateTime = "2025-03-15T09:00:00+08:00"
* performer = Reference(ExampleERefPractitioner)
* valueString = "Chest pain for 2 hours, radiating to left arm"
* note.text = "Patient reports sudden onset of crushing chest pain while at rest"

// =============================================================================
// TDG Row REF-33: Vital Signs - Blood Pressure
// =============================================================================
Instance: ExampleERefObservationBP
InstanceOf: ERefObservation
Usage: #example
Title: "Example Blood Pressure Observation"
Description: "Example blood pressure vital sign for eReferral (REF-33). Referenced via ServiceRequest.supportingInfo."
* status = #final
* category = $observation-category#vital-signs "Vital Signs"
* code = $loinc#85354-9 "Blood pressure panel with all children optional"
* subject = Reference(ExampleERefPatient)
* effectiveDateTime = "2025-03-15T09:15:00+08:00"
* performer = Reference(ExampleERefPractitioner)
* component[0].code = $loinc#8480-6 "Systolic blood pressure"
* component[=].valueQuantity = 160 'mm[Hg]' "mmHg"
* component[+].code = $loinc#8462-4 "Diastolic blood pressure"
* component[=].valueQuantity = 95 'mm[Hg]' "mmHg"
* interpretation = $v3-ObservationInterpretation#H "High"
* note.text = "Patient hypertensive on initial assessment"

// =============================================================================
// TDG Row REF-34: Vital Signs - Heart Rate
// =============================================================================
Instance: ExampleERefObservationHeartRate
InstanceOf: ERefObservation
Usage: #example
Title: "Example Heart Rate Observation"
Description: "Example heart rate vital sign for eReferral (REF-34). Referenced via ServiceRequest.supportingInfo."
* status = #final
* category = $observation-category#vital-signs "Vital Signs"
* code = $loinc#8867-4 "Heart rate"
* subject = Reference(ExampleERefPatient)
* effectiveDateTime = "2025-03-15T09:15:00+08:00"
* performer = Reference(ExampleERefPractitioner)
* valueQuantity = 88 '/min' "beats/minute"
* interpretation = $v3-ObservationInterpretation#N "Normal"

// =============================================================================
// TDG Row REF-35: Vital Signs - Respiratory Rate
// =============================================================================
Instance: ExampleERefObservationRespiratoryRate
InstanceOf: ERefObservation
Usage: #example
Title: "Example Respiratory Rate Observation"
Description: "Example respiratory rate vital sign for eReferral (REF-35). Referenced via ServiceRequest.supportingInfo."
* status = #final
* category = $observation-category#vital-signs "Vital Signs"
* code = $loinc#9279-1 "Respiratory rate"
* subject = Reference(ExampleERefPatient)
* effectiveDateTime = "2025-03-15T09:15:00+08:00"
* performer = Reference(ExampleERefPractitioner)
* valueQuantity = 20 '/min' "breaths/minute"
* interpretation = $v3-ObservationInterpretation#N "Normal"

// =============================================================================
// TDG Row REF-36: Vital Signs - Oxygen Saturation
// =============================================================================
Instance: ExampleERefObservationOxygenSat
InstanceOf: ERefObservation
Usage: #example
Title: "Example Oxygen Saturation Observation"
Description: "Example oxygen saturation vital sign for eReferral (REF-36). Referenced via ServiceRequest.supportingInfo."
* status = #final
* category = $observation-category#vital-signs "Vital Signs"
* code = $loinc#2708-6 "Oxygen saturation in Arterial blood"
* subject = Reference(ExampleERefPatient)
* effectiveDateTime = "2025-03-15T09:15:00+08:00"
* performer = Reference(ExampleERefPractitioner)
* valueQuantity = 96 '%' "%"
* interpretation = $v3-ObservationInterpretation#N "Normal"
* note.text = "Room air saturation"

// =============================================================================
// TDG Row REF-37: Vital Signs - Temperature
// =============================================================================
Instance: ExampleERefObservationTemperature
InstanceOf: ERefObservation
Usage: #example
Title: "Example Body Temperature Observation"
Description: "Example body temperature vital sign for eReferral (REF-37). Referenced via ServiceRequest.supportingInfo."
* status = #final
* category = $observation-category#vital-signs "Vital Signs"
* code = $loinc#8310-5 "Body temperature"
* subject = Reference(ExampleERefPatient)
* effectiveDateTime = "2025-03-15T09:15:00+08:00"
* performer = Reference(ExampleERefPractitioner)
* valueQuantity = 37.2 'Cel' "Celsius"
* interpretation = $v3-ObservationInterpretation#N "Normal"

// =============================================================================
// TDG Row REF-38: Vital Signs - Weight
// =============================================================================
Instance: ExampleERefObservationWeight
InstanceOf: ERefObservation
Usage: #example
Title: "Example Body Weight Observation"
Description: "Example body weight vital sign for eReferral (REF-38). Referenced via ServiceRequest.supportingInfo."
* status = #final
* category = $observation-category#vital-signs "Vital Signs"
* code = $loinc#29463-7 "Body weight"
* subject = Reference(ExampleERefPatient)
* effectiveDateTime = "2025-03-15T09:15:00+08:00"
* performer = Reference(ExampleERefPractitioner)
* valueQuantity = 65 'kg' "kg"

// =============================================================================
// ADDITIONAL CLINICAL OBSERVATIONS
// =============================================================================

// ECG Finding (commonly included in referral summaries)
Instance: ExampleERefObservationECG
InstanceOf: ERefObservation
Usage: #example
Title: "Example ECG Observation"
Description: "Example ECG findings observation for eReferral. Referenced via ServiceRequest.supportingInfo for cardiac referrals."
* status = #final
* category = $observation-category#procedure "Procedure"
* code = $loinc#11524-6 "EKG study"
* subject = Reference(ExampleERefPatient)
* effectiveDateTime = "2025-03-15T09:20:00+08:00"
* performer = Reference(ExampleERefPractitioner)
* valueString = "ST depression in leads V4-V6, T wave inversion in lead III"
* interpretation = $v3-ObservationInterpretation#A "Abnormal"
* note.text = "Suggestive of ischemic changes, cardiology referral recommended"

// Laboratory Result (Glucose)
Instance: ExampleERefObservationLabGlucose
InstanceOf: ERefObservation
Usage: #example
Title: "Example Laboratory Glucose Observation"
Description: "Example laboratory result observation for eReferral with reference range."
* status = #final
* category = $observation-category#laboratory "Laboratory"
* code = $loinc#2339-0 "Glucose [Mass/volume] in Blood"
* subject = Reference(ExampleERefPatient)
* effectiveDateTime = "2025-03-15T08:30:00+08:00"
* performer = Reference(ExampleERefPractitioner)
* valueQuantity = 95 'mg/dL' "mg/dL"
* referenceRange.low = 70 'mg/dL' "mg/dL"
* referenceRange.high = 100 'mg/dL' "mg/dL"
* referenceRange.text = "Normal range"

// =============================================================================
// NOTE: Supporting resources (ExampleERefPatient, ExampleERefPractitioner)
// are defined in separate files and referenced above.
// - ExampleERefPatient: erefpatient-example.fsh
// - ExampleERefPractitioner: ExampleERefPractitioner.fsh
// =============================================================================
