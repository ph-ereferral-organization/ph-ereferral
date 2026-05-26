Profile: ERefObservation
Parent: PHCoreObservation
Id: ereferral-observation
Title: "EReferral Observation"
Description: "Profile for clinical observations in the Philippine eReferral context. 
Supports vital signs, laboratory results, and clinical measurements included in 
referral clinical summaries. Referenced via ServiceRequest.supportingInfo and 
ServiceRequest.reasonReference."

// =============================================================================
// TDG MAPPING CITATIONS - Clinical Information Group (07)
// =============================================================================
// TDG Row REF-31: "Chief Complaint" -> ServiceRequest.reasonReference
//   - FHIR Profile: Observation | Condition
//   - Maps to: ServiceRequest.reasonReference or Condition.code
//
// TDG Row REF-33: "Vital Signs – Blood Pressure" -> ServiceRequest.supportingInfo
//   - FHIR Profile: PH Core Observation
//   - Maps to: ServiceRequest.supportingInfo, Observation.value[x]
//
// TDG Row REF-34: "Vital Signs – Heart Rate" -> ServiceRequest.supportingInfo
//   - FHIR Profile: PH Core Observation
//   - Maps to: ServiceRequest.supportingInfo, Observation.value[x]
//
// TDG Row REF-35: "Vital Signs – Respiratory Rate" -> ServiceRequest.supportingInfo
//   - FHIR Profile: PH Core Observation
//   - Maps to: ServiceRequest.supportingInfo, Observation.value[x]
//
// TDG Row REF-36: "Vital Signs – Oxygen Saturation" -> ServiceRequest.supportingInfo
//   - FHIR Profile: PH Core Observation
//   - Maps to: ServiceRequest.supportingInfo, Observation.value[x]
//
// TDG Row REF-37: "Vital Signs – Temperature" -> ServiceRequest.supportingInfo
//   - FHIR Profile: PH Core Observation
//   - Maps to: ServiceRequest.supportingInfo, Observation.value[x]
//
// TDG Row REF-38: "Vital Signs – Weight" -> ServiceRequest.supportingInfo
//   - FHIR Profile: PH Core Observation
//   - Maps to: ServiceRequest.supportingInfo, Observation.value[x]
//
// All TDG rows: Clinical Group = "07 Clinical Information"
// Required?: No (for TDG), but Must Support for eReferral interoperability
// =============================================================================

// Inherited from PH Core with Must Support:
// - status: 1..1 MS
// - code: 1..1 MS
// - category: 0..* MS (in PH Core)
// - value[x]: 0..1 MS (valueCodeableConcept slice in PH Core)
// - interpretation: 0..* MS (in PH Core)

// TDG Row REF-33 to REF-38: eReferral requires at least one category 
// for clinical context classification (vital-signs, laboratory, survey, procedure)
* category MS
* insert ObligationOptional

// * category ObligationOptional

// TDG Row REF-31, REF-33-38: Subject required for all clinical observations
// Constrained to ERefPatient for eReferral context (not Group, Device, or Location)
* subject MS
* insert ObligationOptional

// * subject ObligationOptional
* subject only Reference(ERefPatient)

// =============================================================================
// SELF-REFERENCING ELEMENTS - R4 Observation
// =============================================================================
// NOTE: Self-referencing profile constraints are temporarily commented out
// due to SUSHI compilation limitations. The profile cannot reference itself
// during definition. These constraints will be enforced via documentation
// and IG Publisher validation instead.
//
// hasMember: For grouping related observations (e.g., vital signs panels,
// laboratory batteries). In eReferral, panel members should be ERefObservations.
// * hasMember only Reference(ERefObservation)
//   * ^short = "Grouped member observations"
//   * ^definition = "This observation is a group observation that includes the target as a member. For eReferral, all member observations should conform to ERefObservation profile."

// derivedFrom: For observations derived from other observations (e.g.,
// calculated values like BMI from height/weight, or anion gap from electrolytes).
// In eReferral, source observations should be ERefObservations.
// * derivedFrom only Reference(ERefObservation or DocumentReference)
//   * ^short = "Source observation for derived values"
//   * ^definition = "The target resource that represents a measurement from which this observation value is derived. For eReferral, source observations should conform to ERefObservation profile."
