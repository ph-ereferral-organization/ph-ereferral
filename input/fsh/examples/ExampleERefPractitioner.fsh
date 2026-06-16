// TDG Mapping: REF-1 - Name of Referring Practitioner
Instance: ExampleERefPractitioner
InstanceOf: PHCorePractitioner
Usage: #example
Title: "Example Referring Practitioner"
Description: "Example referring practitioner demonstrating practitioner demographics for the Philippines eReferral workflow."

// REF-1: Name of Referring Practitioner
* name.family = "Santos"
* name.given[0] = "Maria"
* name.given[+] = "Cruz"
* name.prefix = "Dr."
* name.text = "Dr. Maria Cruz Santos"

* identifier.system = "urn:oid:2.16.840.1.113883.2.9.4.3.3"
* identifier.value = "PRAC-12345"
* active = true
* name.use = #official
* telecom[0].system = #phone
* telecom[0].value = "+63 2 8123 4567"
* telecom[0].use = #work
* telecom[1].system = #email
* telecom[1].value = "mcsantos@hospital.ph"
* telecom[1].use = #work
* gender = #female
* qualification.code = $sct#158965000 "Medical practitioner"
