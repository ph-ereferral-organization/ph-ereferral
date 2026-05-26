// ERefPatient Profile - Philippine eReferral Patient
// Extends PHCorePatient with eReferral-specific elements

Profile: ERefPatient
Parent: PHCorePatient
Id: ereferral-patient
Title: "ERefPatient"
Description: "Patient profile for the Philippine eReferral system. Extends PHCorePatient with additional elements specific to referral workflows, including PWD (Person with Disability) registration information. This profile supports the patient demographic requirements defined in the eReferral TDG (Technical Development Group) mapping, elements REF-21 through REF-30."

* ^status = #draft
* ^experimental = true
* ^purpose = "To standardize patient demographic information for Philippine healthcare referrals, ensuring interoperability between referring and receiving facilities."

// Inherited from PHCorePatient:
// - identifier: PHCorePhilHealthID, PHCorePhilSysID (REF-25, REF-26)
// - name: Patient name (REF-21)
// - gender: Administrative gender (REF-22)
// - birthDate: Date of birth (REF-23)
// - address: Address with PSGC extensions (REF-27)
// - telecom: Contact information (REF-28)
// - contact: Next of kin (REF-29)
// - extension: nationality, religion, indigenousGroup, indigenousPeople, occupation, race, educationalAttainment

// eReferral-specific extensions
* extension contains
    PWDDisabilityExtension named disabilityRegistration 0..1 MS
* insert ObligationOptional

* extension[disabilityRegistration] ^short = "PWD Registration Information"
* extension[disabilityRegistration] ^definition = "Person With Disability (PWD) registration information including PWD ID number, type of disability, and ID expiration date. (REF-30)"
* extension[disabilityRegistration] ^mustSupport = true

// Contact information for Next of Kin (REF-29)
// Using existing Patient.contact element with specific constraints for eReferral
* contact ^short = "Accompanied By / Next of Kin"
* contact ^definition = "Contact details for the patient's companion, guardian, or next of kin who may be contacted regarding the referral. (REF-29)"

* contact.relationship 1.. MS
* insert ObligationRequired

// * contact.relationship from http://terminology.hl7.org/ValueSet/patient-contactrelationship (extensible)
* contact.name 1.. MS
* insert ObligationRequired

* contact.telecom MS
* insert ObligationOptional


// Address requirements for referral
// PHCorePatient already provides PSGC extensions via PHCoreAddress
* address MS
* insert ObligationOptional

* address ^short = "Patient Address"
* address ^definition = "Current residence address of the patient. Use PHCoreAddress extensions for PSGC-coded barangay, city/municipality, and province. (REF-27)"

// Telecom requirements
* telecom MS
* insert ObligationOptional

* telecom ^short = "Contact Number"
* telecom ^definition = "Patient's contact information including phone numbers and email addresses. (REF-28)"
* telecom.system from http://hl7.org/fhir/ValueSet/contact-point-system (required)
* telecom.use from http://hl7.org/fhir/ValueSet/contact-point-use (required)

// Make key referral demographics required as per TDG mapping
* name 1.. MS
* insert ObligationRequired

* gender 1.. MS
* insert ObligationRequired

* birthDate 1.. MS
* insert ObligationRequired


// Invariant: If contact is provided, relationship should indicate the nature of the relationship
Invariant: ereferral-patient-1
Description: "If contact is provided, either name or telecom must be present."
Severity: #error
Expression: "contact.exists() implies contact.all(name.exists() or telecom.exists())"

// Invariant: PWD ID should have expiration date if provided
Invariant: ereferral-patient-2
Description: "If PWD registration is provided with an ID, expiration date should also be provided."
Severity: #warning
Expression: "extension('urn://example.com/ph-ereferral/fhir/StructureDefinition/ereferral-pwd-disability').extension('pwdId').exists() implies extension('urn://example.com/ph-ereferral/fhir/StructureDefinition/ereferral-pwd-disability').extension('idExpirationDate').exists()"
