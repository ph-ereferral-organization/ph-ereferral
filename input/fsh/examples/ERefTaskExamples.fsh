// =============================================================================
// ERefTask Examples - Self-Contained Pattern
// 3 workflow states: Requested → Accepted → Completed
// All supporting resources defined in this file to avoid cross-file dependencies
// =============================================================================

// =============================================================================
// PRIMARY EXAMPLES: Task Workflow States
// =============================================================================

Instance: ExampleERefTaskRequested
InstanceOf: ERefTask
Usage: #example
Title: "Example eReferral Task - Requested State"
Description: "Task representing a newly created eReferral in 'requested' status. Demonstrates TDG REF-9 'Care Navigator' assignment pattern with requester populated but owner not yet assigned."

* status = #requested
* intent = #order
* code = $sct#3457005 "Patient referral"
* code.text = "eReferral for cardiology consultation"
* focus = Reference(ExampleERefServiceRequestTask)
* for = Reference(ExampleERefPatientTask)
* requester = Reference(ExampleERefPractitionerRoleRequester)
* authoredOn = "2025-03-15T09:30:00+08:00"
* lastModified = "2025-03-15T09:30:00+08:00"
* note.text = "New referral for patient with chest pain. Awaiting acceptance by receiving facility."

Instance: ExampleERefTaskAccepted
InstanceOf: ERefTask
Usage: #example
Title: "Example eReferral Task - Accepted State"
Description: "Task representing an eReferral that has been accepted by the receiving facility. Demonstrates TDG REF-9 'Care Navigator' assignment with owner now populated."

* status = #accepted
* intent = #order
* code = $sct#3457005 "Patient referral"
* code.text = "eReferral for cardiology consultation"
* focus = Reference(ExampleERefServiceRequestTask)
* for = Reference(ExampleERefPatientTask)
* requester = Reference(ExampleERefPractitionerRoleRequester)
* owner = Reference(ExampleERefOrganizationReceiving)
* authoredOn = "2025-03-15T09:30:00+08:00"
* lastModified = "2025-03-15T14:22:00+08:00"
* executionPeriod.start = "2025-03-15T14:22:00+08:00"
* note[0].text = "New referral for patient with chest pain. Awaiting acceptance by receiving facility."
* note[1].text = "Accepted by Manila General Hospital. Care navigator assigned."

Instance: ExampleERefTaskCompleted
InstanceOf: ERefTask
Usage: #example
Title: "Example eReferral Task - Completed State"
Description: "Task representing a completed eReferral. Demonstrates full workflow closure with execution period and completion output."

* status = #completed
* intent = #order
* code = $sct#3457005 "Patient referral"
* code.text = "eReferral for cardiology consultation"
* focus = Reference(ExampleERefServiceRequestTask)
* for = Reference(ExampleERefPatientTask)
* requester = Reference(ExampleERefPractitionerRoleRequester)
* owner = Reference(ExampleERefOrganizationReceiving)
* authoredOn = "2025-03-15T09:30:00+08:00"
* lastModified = "2025-03-18T16:45:00+08:00"
* executionPeriod.start = "2025-03-15T14:22:00+08:00"
* executionPeriod.end = "2025-03-18T16:45:00+08:00"
* note[0].text = "New referral for patient with chest pain. Awaiting acceptance by receiving facility."
* note[1].text = "Accepted by Manila General Hospital. Care navigator assigned."
* note[2].text = "Patient seen by Dr. Reyes. Angiography performed. Patient stable, discharged with medications."
* output[0].type = $sct#721927009 "Referral note"
* output[=].type.text = "Consultation summary"
* output[=].valueString = "Cardiology consultation completed. No acute coronary syndrome. Medication adjustment recommended."

// =============================================================================
// SUPPORTING RESOURCES (Self-Contained Pattern)
// Minimal instances required for the 3 Task examples above
// =============================================================================

Instance: ExampleERefPatientTask
InstanceOf: PHCorePatient
Usage: #example
Title: "Example eReferral Patient (for Task)"
Description: "Minimal patient instance for ERefTask demonstration."

* identifier.system = "urn:oid:2.16.840.1.113883.2.9.4.3.2"
* identifier.value = "PH-123456789"
* name.family = "Dela Cruz"
* name.given[0] = "Juan"
* gender = #male
* birthDate = "1965-07-20"

Instance: ExampleERefPractitionerRequester
InstanceOf: PHCorePractitioner
Usage: #example
Title: "Example Referring Practitioner (for Task)"
Description: "Minimal practitioner instance for ERefTask demonstration."

* identifier.system = "urn:oid:2.16.840.1.113883.2.9.4.3.3"
* identifier.value = "MD-98765"
* name.family = "Santos"
* name.given[0] = "Maria"
* name.prefix = "Dr."
* gender = #female

Instance: ExampleERefOrganizationRequester
InstanceOf: PHCoreOrganization
Usage: #example
Title: "Example Referring Facility (for Task)"
Description: "Minimal organization instance representing the referring facility."

* identifier.system = "http://fhir.nhdr.gov.ph/nhfr/hospcode"
* identifier.value = "DOH123456"
* name = "Rural Health Unit - Barangay Health Center"
* address.line = "123 Health Center Road"
* address.city = "Quezon City"
* address.state = "Metro Manila"
* address.country = "PH"

Instance: ExampleERefPractitionerRoleRequester
InstanceOf: PHCorePractitionerRole
Usage: #example
Title: "Example Referring Practitioner Role (for Task)"
Description: "Practitioner role linking referring practitioner to their facility."

* active = true
* practitioner = Reference(ExampleERefPractitionerRequester)
* organization = Reference(ExampleERefOrganizationRequester)
* code = $sct#158965000 "Medical practitioner"

Instance: ExampleERefOrganizationReceiving
InstanceOf: PHCoreOrganization
Usage: #example
Title: "Example Receiving Facility (for Task)"
Description: "Organization instance representing the receiving tertiary hospital."

* identifier.system = "http://fhir.nhdr.gov.ph/nhfr/hospcode"
* identifier.value = "DOH789012"
* name = "Manila General Hospital"
* type = $organization-type#prov "Healthcare Provider"
* address.line = "456 Hospital Drive"
* address.city = "Manila"
* address.state = "Metro Manila"
* address.country = "PH"

Instance: ExampleERefServiceRequestTask
InstanceOf: ERefServiceRequest
Usage: #example
Title: "Example ServiceRequest (for Task)"
Description: "Minimal ServiceRequest instance referenced by Task examples."

* status = #active
* intent = #order
* code = $sct#183519001 "Referral to cardiology service"
* subject = Reference(ExampleERefPatientTask)
* authoredOn = "2025-03-15T09:30:00+08:00"
* requester = Reference(ExampleERefPractitionerRoleRequester)
* reasonCode = $sct#29857009 "Chest pain"
  * text = "Chest pain on exertion, suspected unstable angina"
