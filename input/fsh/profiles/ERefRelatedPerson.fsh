Profile: ERefRelatedPerson
Parent: PHCoreRelatedPerson
Id: ereferral-related-person
Title: "EReferral RelatedPerson"
Description: "RelatedPerson profile for the Philippine eReferral system. This profile represents optional patient contacts used in referral workflows, including next of kin, emergency contacts, accompanying persons, and guardians. It extends PHCoreRelatedPerson and maps to TDG element REF-29."

* relationship MS
* relationship insert ObligationOptional

// TDG REF-29: Accompanied By / Next of Kin
* patient MS
* patient insert ObligationOptional

* patient ^short = "Patient associated with this contact"
* patient ^definition = "The patient this related person is associated with. RelatedPerson.patient remains required by the inherited FHIR structure, while use of a separate RelatedPerson resource in an eReferral is optional."

* name MS
* name insert ObligationOptional

* telecom MS
* telecom insert ObligationOptional