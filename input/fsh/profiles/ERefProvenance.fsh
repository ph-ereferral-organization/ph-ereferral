Profile: ERefProvenance
Parent: PHCoreProvenance
Id: ereferral-provenance
Title: "EReferral Provenance"
Description: "Profile for tracking audit trail of eReferral actions including signatures and timestamps in the Philippine eReferral context."


// Reference constraint: target must be eReferral ServiceRequest
* target only Reference(ERefServiceRequest)

// TDG Row REF-3: "Date & Time of Signature"
* recorded MS
* recorded insert ObligationOptional

// TDG Row REF-4: "Professional Signature" -> Provenance.signature with child constraints per issue #31
// Must Support and cardinality for professional signature (REF-4)
* signature MS
* signature insert ObligationOptional
* signature.who MS
* signature.who only Reference(ERefPractitionerRole)
* signature.data MS
* signature.data insert ObligationOptional
