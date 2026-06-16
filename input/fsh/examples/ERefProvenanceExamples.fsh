// === PRIMARY EXAMPLES ===

Instance: ExampleERefProvenanceSignature
InstanceOf: ERefProvenance
Usage: #example
Title: "Example eReferral Provenance with Signature"
Description: "Provenance record demonstrating professional signature attestation for a referral. Demonstrates REF-3 (Date & Time of Signature) and REF-4 (Professional Signature)."

* target = Reference(ExampleERefServiceRequestMinimal)
* recorded = "2025-03-15T09:30:00+08:00"
* activity = $v3-DataOperation#CREATE "create"
* agent[0].type = $provenance-participant-type#author "Author"
* agent[=].who = Reference(ExampleERefPractitionerRoleMinimal)
* agent[=].onBehalfOf = Reference(ExampleERefOrganizationMinimal)
* signature[0].type = $signature-type#1.2.840.10065.1.12.1.5 "Verification Signature"
* signature[=].when = "2025-03-15T09:30:00+08:00"
* signature[=].who = Reference(ExampleERefPractitionerRoleMinimal)
* signature[=].data = "dGVzdHNpZ25hdHVyZWJhc2U2NA=="
* signature[=].sigFormat = #application/signature+xml

Instance: ExampleERefProvenanceUpdate
InstanceOf: ERefProvenance
Usage: #example
Title: "Example eReferral Provenance for Status Update"
Description: "Provenance record documenting a referral status update without signature. Demonstrates REF-3 (Date & Time of activity)."

* target = Reference(ExampleERefServiceRequestMinimal)
* recorded = "2025-03-16T14:22:00+08:00"
* activity = $v3-DataOperation#UPDATE "revise"
* agent[0].type = $provenance-participant-type#author "Author"
* agent[=].who = Reference(ExampleERefPractitionerRoleMinimal)
* agent[=].onBehalfOf = Reference(ExampleERefOrganizationMinimal)


// === SUPPORTING RESOURCES (Self-Contained) ===

Instance: ExampleERefPatientMinimal
InstanceOf: PHCorePatient
Usage: #example
Title: "Example eReferral Patient (Minimal)"
Description: "Minimal patient instance for Provenance demonstration."
* identifier.system = "urn:oid:2.16.840.1.113883.2.9.4.3.2"
* identifier.value = "PH-123456789"
* name.family = "Dela Cruz"
* name.given[0] = "Juan"
* gender = #male
* birthDate = "1965-07-20"

Instance: ExampleERefPractitionerMinimal
InstanceOf: PHCorePractitioner
Usage: #example
Title: "Example Referring Practitioner (Minimal)"
Description: "Minimal practitioner instance for Provenance demonstration."
* identifier.system = "urn:oid:2.16.840.1.113883.2.9.4.3.3"
* identifier.value = "MD-98765"
* name.family = "Santos"
* name.given[0] = "Maria"
* name.prefix = "Dr."
* gender = #female

Instance: ExampleERefPractitionerRoleMinimal
InstanceOf: PHCorePractitionerRole
Usage: #example
Title: "Example Referring Practitioner Role (Minimal)"
Description: "Minimal practitioner role instance for Provenance demonstration."
* active = true
* practitioner = Reference(ExampleERefPractitionerMinimal)
* organization = Reference(ExampleERefOrganizationMinimal)
* code = $sct#158965000 "Medical practitioner"

Instance: ExampleERefOrganizationMinimal
InstanceOf: PHCoreOrganization
Usage: #example
Title: "Example Referring Facility (Minimal)"
Description: "Minimal organization instance for Provenance demonstration."
* identifier.system = "http://fhir.nhdr.gov.ph/nhfr/hospcode"
* identifier.value = "DOH123456"
* name = "Rural Health Unit - Barangay Health Center"
* address.line = "123 Health Center Road"
* address.city = "Quezon City"
* address.state = "Metro Manila"
* address.country = "PH"

Instance: ExampleERefServiceRequestMinimal
InstanceOf: ERefServiceRequest
Usage: #example
Title: "Example eReferral Service Request (Minimal)"
Description: "Minimal service request instance for Provenance demonstration."
* status = #active
* intent = #order
* code = $sct#103696004 "Patient referral to specialist"
* subject = Reference(ExampleERefPatientMinimal)
* authoredOn = "2025-03-15T09:30:00+08:00"
* requester = Reference(ExampleERefPractitionerRoleMinimal)
