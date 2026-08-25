// TDG Mappings (Synchronous TDG FHIR Mapping Specification):
// - REF-1: Name of Referring Practitioner (sending side)
// - REF-9: Care Navigator (receiving side)
// - REF-2: Practitioner Role
// - REF-5: Initiating Facility Name
// - REF-6: Initiating Facility NHFR Code
// - REF-7: Initiating Facility Address
// - REF-8: Initiating Facility Contact Number
// - REF-10: Receiving Facility Name
// - REF-11: Receiving Facility NHFR Code

Profile: ERefPractitionerRole
Parent: PHCorePractitionerRole
Id: ereferral-practitioner-role
Title: "PH eReferral PractitionerRole"
Description: "Profile on PractitionerRole for the Philippines eReferral specification, extending PHCorePractitionerRole. This profile captures the role of the referring practitioner and care navigator within the eReferral workflow, linking practitioners to healthcare facilities."

// Inherited from PHCorePractitionerRole:
// - practitioner 1..1 MS (REF-1, REF-9) - already constrained to PHCorePractitioner
// - organization 1..1 MS (REF-5, REF-6, REF-7, REF-8, REF-10, REF-11) - already constrained to PHCoreOrganization
// Do not redeclare elements that PH Core already constrains with MS flags and proper references.

// eReferral-specific extension:
// TDG REF-2: Practitioner Role - Must Support for eReferral workflow
* code MS
* code from EReferralPractitionerRoleCode (required)
* code insert ObligationRequired

* practitioner MS
* practitioner insert ObligationOptional
* practitioner only Reference(PHCorePractitioner)

* organization MS
* organization insert ObligationOptional
* organization only Reference(PHCoreOrganization)