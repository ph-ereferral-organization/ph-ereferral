Profile: ERefProvenance
Parent: PHCoreProvenance
Id: ereferral-provenance
Title: "EReferral Provenance"
Description: "Profile for tracking audit trail of eReferral actions including signatures and timestamps in the Philippine eReferral context."

// TDG Row REF-3: "Date & Time of Signature" -> Provenance.recorded (inherited 1..1 MS from PH Core)
// TDG Row REF-4: "Professional Signature" -> Provenance.signature with child constraints per issue #31

// Reference constraint: target must be eReferral ServiceRequest
* target only Reference(ERefServiceRequest)

// Must Support and cardinality for professional signature (REF-4)
* signature MS
* insert ObligationOptional

* signature.type 1..*
* signature.when 1..1
* signature.who 1..1
* signature.data 1..1

// All other Must Support elements inherited from PH Core:
// - target (1..* MS)
// - recorded (1..1 MS) - captures REF-3 Date & Time of Signature
// - agent (1..* MS), agent.who (1..1 MS), agent.type (MS)
// - activity (MS)
