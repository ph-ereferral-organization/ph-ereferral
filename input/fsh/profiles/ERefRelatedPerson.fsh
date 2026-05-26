Profile: ERefRelatedPerson
Parent: PHCoreRelatedPerson
Id: ereferral-related-person
Title: "EReferral RelatedPerson"
Description: "RelatedPerson profile for the Philippine eReferral system. This profile represents optional patient contacts used in referral workflows, including next of kin, emergency contacts, accompanying persons, and guardians. It extends PHCoreRelatedPerson and maps to TDG element REF-29."

* ^status = #draft
* ^experimental = true
* ^jurisdiction = urn:iso:std:iso:3166#PH "Philippines"
* ^purpose = "To standardize patient contacts, next of kin, accompanying persons, and guardians when these persons are exchanged as separate RelatedPerson resources in the Philippine eReferral workflow. The resource is optional for a referral, but when present it must identify the patient it is related to."

// TDG REF-29: Accompanied By / Next of Kin
* patient MS
* insert ObligationOptional

* patient ^short = "Patient associated with this contact"
* patient ^definition = "The patient this related person is associated with. RelatedPerson.patient remains required by the inherited FHIR structure, while use of a separate RelatedPerson resource in an eReferral is optional."

* relationship MS
* insert ObligationOptional

* relationship from EReferralRelationshipType (extensible)
* relationship ^short = "Relationship to the patient"
* relationship ^definition = "The relationship role of this person to the patient, such as next of kin, emergency contact, guardian, spouse, parent, or accompanying family member. (REF-29)"

* name MS
* insert ObligationOptional

* name ^short = "Name of related person"
* name ^definition = "Name of the related person, next of kin, guardian, or accompanying person. (REF-29)"

* telecom MS
* insert ObligationOptional

* telecom ^short = "Contact details for related person"
* telecom ^definition = "Phone, email, or other contact details for reaching the related person about the referral. (REF-29)"

* address MS
* insert ObligationOptional

* address ^short = "Address of related person"
* address ^definition = "Address where the related person can be contacted or visited."

* gender MS
* insert ObligationOptional

* gender ^short = "Administrative gender"
* gender ^definition = "Administrative gender of the related person when collected."

* birthDate MS
* insert ObligationOptional

* birthDate ^short = "Date of birth"
* birthDate ^definition = "Birth date of the related person when collected."

* period MS
* insert ObligationOptional

* period ^short = "Relationship validity period"
* period ^definition = "Period when this related-person relationship is valid for the referral context."
