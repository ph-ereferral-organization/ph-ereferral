Instance: ExampleERefPractitionerRole
InstanceOf: PHCorePractitionerRole
Usage: #example
Title: "Example Referring Practitioner Role"
Description: "Example referring practitioner with role and organization"
* identifier.system = "urn:oid:2.16.840.1.113883.2.9.4.3.3"
* identifier.value = "MD-98765"
* active = true
* practitioner = Reference(ExampleERefPractitioner)
* organization = Reference(ExampleERefReferringFacility)
* code = $sct#158965000 "Medical practitioner"
* specialty = $sct#419192003 "Internal medicine"
* telecom.system = #phone
* telecom.value = "+63 2 8123 4567"
* telecom.use = #work
