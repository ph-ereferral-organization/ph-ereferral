// Example: EReferral Patient
// Demonstrates ERefPatient profile with all key elements

Instance: ERefPatientExample
InstanceOf: ERefPatient
Usage: #example
Title: "ERefPatient Example - Juan Dela Cruz"
Description: "Example patient instance demonstrating the ERefPatient profile with PhilHealth ID, PhilSys ID, PWD registration, and complete demographic information for eReferral."

// Patient identifiers (PHCorePhilHealthID, PHCorePhilSysID)
* identifier[PHCorePhilHealthID].system = $PhilHealthID
* identifier[PHCorePhilHealthID].value = "63-584789845-5"

* identifier[PHCorePhilSysID].system = $PhilSysID
* identifier[PHCorePhilSysID].value = "1234-5678-9012-3456"

// Patient name (REF-21)
* name.use = #official
* name.family = "Dela Cruz"
* name.given[+] = "Juan"
* name.given[+] = "Dela Fuente"

// Administrative gender (REF-22)
* gender = #male

// Birth date (REF-23)
* birthDate = "1985-06-15"

// Active status
* active = true

// Contact information - phone (REF-28)
* telecom[0].system = #phone
* telecom[0].value = "+639171234567"
* telecom[0].use = #mobile

* telecom[1].system = #email
* telecom[1].value = "juandelacruz@example.com"
* telecom[1].use = #home

// Address with PSGC extensions (REF-27)
* address.use = #home
* address.type = #physical
* address.line[0] = "123 Mabini Street"
* address.postalCode = "1100"
* address.country = "PH"

// PSGC extensions are inherited from PHCoreAddress via PHCorePatient
// These are applied using the PHCore extensions
* address.extension[barangay].valueCoding = $PSGC#1380100001 "Barangay 1"
* address.extension[cityMunicipality].valueCoding = $PSGC#1380200000 "City of Las Piñas"
* address.extension[province].valueCoding = $PSGC#0402100000 "Cavite"

// Next of Kin / Accompanied By (REF-29)
* contact[0].relationship[0] = http://terminology.hl7.org/CodeSystem/v3-RoleCode#FTH "Father"
* contact[0].name.use = #official
* contact[0].name.family = "Dela Cruz"
* contact[0].name.given[0] = "Roberto"
* contact[0].telecom[0].system = #phone
* contact[0].telecom[0].value = "+639189876543"
* contact[0].telecom[0].use = #mobile

// Extensions inherited from PHCorePatient
* extension[nationality].extension[code].valueCodeableConcept = urn:iso:std:iso:3166#PH "Philippines"
* extension[religion].valueCodeableConcept = http://terminology.hl7.org/CodeSystem/v3-ReligiousAffiliation#1025 "Jehovah's Witnesses"
* extension[race].valueCodeableConcept = http://terminology.hl7.org/CodeSystem/v3-Race#2036-2 "Filipino"

// PWD Disability Registration (REF-30) - eReferral-specific
* extension[disabilityRegistration].extension[pwdId].valueString = "PWD-NCR-QC-123456"
* extension[disabilityRegistration].extension[disabilityType][0].valueCodeableConcept = PWDDisabilityTypeCS#physical "Physical/Orthopedic Disability"
* extension[disabilityRegistration].extension[idExpirationDate].valueDate = "2027-03-15"

// Text narrative
* text.status = #generated
* text.div = "<div xmlns='http://www.w3.org/1999/xhtml'>Juan Dela Cruz is a male patient born on 15 June 1985, residing in Barangay Malinis, Quezon City, NCR, Philippines. Contact: +639171234567. PWD ID: PWD-NCR-QC-123456 (expires 2027-03-15). Father contact: Roberto Dela Cruz.</div>"
