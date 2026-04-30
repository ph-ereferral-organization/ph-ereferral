// Example: EReferral Immunization - Routine Immunization
// Demonstrates ERefImmunization profile with routine vaccination (MMR - Measles-Mumps-Rubella)

Instance: ExampleERefImmunizationRoutine
InstanceOf: ERefImmunization
Usage: #example
Title: "ERefImmunization Example - Routine Immunization (MMR)"
Description: "Example immunization instance demonstrating routine vaccination (MMR - Measles-Mumps-Rubella) as supporting clinical information in an eReferral context via ServiceRequest.supportingInfo."

// Business identifier
* identifier[0].system = "http://example.ph/immunization-records"
* identifier[0].value = "IMM-2025-00123"

// Status (MS) - completed routine vaccination
* status = #completed

// Vaccine code (MS) - MMR using active SNOMED CT product code
* vaccineCode = $sct#871831003 "MMR (measles and mumps and rubella) vaccine"

// Occurrence (MS) - date of vaccine administration
* occurrenceDateTime = "2025-03-15"

// Patient (MS) - who was immunized
* patient = Reference(Patient/ERefPatientExample)

// When record was created
* recorded = "2025-03-15T09:30:00+08:00"

// Primary source - directly recorded at time of administration
* primarySource = true

// Location where immunization occurred
* location.display = "Quezon City Health Center No. 1"

// Vaccine manufacturer
* manufacturer.display = "Serum Institute of India"

// Vaccine lot number
* lotNumber = "LOT-2025-MMR-0045"

// Vaccine expiration date
* expirationDate = "2026-12-31"

// Body site - left thigh (valid subcutaneous site for MMR)
* site = $sct#61396006 "Structure of left thigh"

// Route - subcutaneous injection (standard MMR route)
* route = $sct#34206005 "Subcutaneous route"

// Dose quantity
* doseQuantity.value = 0.5
* doseQuantity.unit = "mL"
* doseQuantity.system = "http://unitsofmeasure.org"
* doseQuantity.code = #mL

// Performer - administering provider
* performer[0].function = http://terminology.hl7.org/CodeSystem/v2-0443#AP "Administering Provider"
* performer[0].actor.display = "Nurse Maria Santos, RN"

// Reason code - routine immunization for active immunity
* reasonCode[0] = $sct#33879002 "Administration of vaccine to produce active immunity (procedure)"

// Dose not subpotent
* isSubpotent = false

// Program eligibility - text only; no standard code for "eligible" exists in v1.0.1 of the FHIR code system
* programEligibility[0].text = "Eligible - DOH Expanded Program on Immunization (EPI)"

// Funding source - public health program (DOH/EPI)
* fundingSource = http://terminology.hl7.org/CodeSystem/immunization-funding-source#public "Public"

// Protocol applied - MMR 2-dose series, first dose
* protocolApplied[0].series = "MMR 2-Dose Series"
* protocolApplied[0].targetDisease[0] = $sct#14189004 "Measles (disorder)"
* protocolApplied[0].targetDisease[1] = $sct#36989005 "Mumps (disorder)"
* protocolApplied[0].targetDisease[2] = $sct#36653000 "Rubella (disorder)"
* protocolApplied[0].doseNumberPositiveInt = 1
* protocolApplied[0].seriesDosesPositiveInt = 2

// Text narrative
* text.status = #generated
* text.div = "<div xmlns='http://www.w3.org/1999/xhtml'>Routine MMR (Measles-Mumps-Rubella) vaccination administered to Juan Dela Cruz on 15 March 2025 at Quezon City Health Center No. 1. Vaccine lot: LOT-2025-MMR-0045 (expires 2026-12-31), manufactured by Serum Institute of India. Dose 1 of 2 administered subcutaneously (0.5 mL) in the left thigh by Nurse Maria Santos, RN. Funded under the national Expanded Program on Immunization (EPI).</div>"
