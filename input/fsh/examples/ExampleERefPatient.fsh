Instance: ExampleERefPatient
InstanceOf: PHCorePatient
Usage: #example
Title: "Example eReferral Patient"
Description: "Example patient for eReferral demonstration"
* identifier.system = "urn:oid:2.16.840.1.113883.2.9.4.3.2"
* identifier.value = "PH-123456789"
* name.family = "Dela Cruz"
* name.given[0] = "Juan"
* name.given[+] = "Miguel"
* gender = #male
* birthDate = "1965-07-20"
* address.use = #home
* address.line = "123 Mabini St"
* address.city = "Quezon City"
* address.state = "Metro Manila"
* address.postalCode = "1100"
* address.country = "PH"
* telecom[0].system = #phone
* telecom[=].value = "+63 912 345 6789"
* telecom[=].use = #mobile
* telecom[+].system = #email
* telecom[=].value = "juan.delacruz@email.com"
