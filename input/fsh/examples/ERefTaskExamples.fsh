// =============================================================================
// ERefTask Examples - Self-Contained Pattern
// Receiving workflow states: Requested -> Received -> Accepted / Rejected /
// Referred onward -> Completed
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
* note.text = "New referral for patient with chest pain. Awaiting receiving-facility response."

Instance: ExampleERefTaskReceived
InstanceOf: ERefTask
Usage: #example
Title: "Example eReferral Task - Received State"
Description: "Task representing an eReferral acknowledged by the receiving facility and under review for acceptance."

* status = #received
* businessStatus = EReferralWorkflowCS#received "Received"
* intent = #order
* code = $sct#3457005 "Patient referral"
* code.text = "eReferral for cardiology consultation"
* focus = Reference(ExampleERefServiceRequestTask)
* for = Reference(ExampleERefPatientTask)
* requester = Reference(ExampleERefPractitionerRoleRequester)
* owner = Reference(ExampleERefOrganizationReceiving)
* authoredOn = "2025-03-15T09:30:00+08:00"
* lastModified = "2025-03-15T09:45:00+08:00"
* note[0].text = "New referral for patient with chest pain. Awaiting receiving-facility response."
* note[1].text = "Referral received by Manila General Hospital and queued for clinical review."

Instance: ExampleERefTaskAccepted
InstanceOf: ERefTask
Usage: #example
Title: "Example eReferral Task - Accepted State"
Description: "Task representing an eReferral that has been accepted by the receiving facility. Demonstrates TDG REF-9 'Care Navigator' assignment with owner now populated."

* status = #accepted
* businessStatus = EReferralWorkflowCS#accepted "Accepted"
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
* note[0].text = "New referral for patient with chest pain. Awaiting receiving-facility response."
* note[1].text = "Accepted by Manila General Hospital. Care navigator assigned."

Instance: ExampleERefTaskRejected
InstanceOf: ERefTask
Usage: #example
Title: "Example eReferral Task - Rejected State"
Description: "Task representing an eReferral response where the receiving facility cannot take the case and no onward facility is specified."

* status = #rejected
* businessStatus = EReferralWorkflowCS#rejected "Rejected"
* intent = #order
* code = $sct#3457005 "Patient referral"
* code.text = "eReferral for cardiology consultation"
* focus = Reference(ExampleERefServiceRequestTask)
* for = Reference(ExampleERefPatientTask)
* requester = Reference(ExampleERefPractitionerRoleRequester)
* owner = Reference(ExampleERefOrganizationReceiving)
* authoredOn = "2025-03-15T09:30:00+08:00"
* lastModified = "2025-03-15T10:05:00+08:00"
* statusReason.text = "Receiving facility cannot take the case. No onward receiving facility was identified in this response."
* note[0].text = "New referral for patient with chest pain. Awaiting receiving-facility response."
* note[1].text = "Manila General Hospital cannot take the case. Referring facility must determine the next action."

Instance: ExampleERefTaskReferredOnward
InstanceOf: ERefTask
Usage: #example
Title: "Example eReferral Task - Referred Onward State"
Description: "Task representing an eReferral response where the receiving facility cannot take the case and directs the referral to another facility."

* status = #rejected
* businessStatus = EReferralWorkflowCS#referred-onward "Referred onward"
* intent = #order
* code = $sct#3457005 "Patient referral"
* code.text = "eReferral for cardiology consultation"
* focus = Reference(ExampleERefServiceRequestTask)
* for = Reference(ExampleERefPatientTask)
* requester = Reference(ExampleERefPractitionerRoleRequester)
* owner = Reference(ExampleERefOrganizationReceiving)
* authoredOn = "2025-03-15T09:30:00+08:00"
* lastModified = "2025-03-15T10:10:00+08:00"
* statusReason = EReferralWorkflowCS#capacity-full "Capacity full"
* note[0].text = "New referral for patient with chest pain. Awaiting receiving-facility response."
* note[1].text = "Manila General Hospital reports capacity full and directs transfer to Eastern District Medical Center."
* output[0].type = EReferralWorkflowCS#onward-referral-request "Onward referral request"
* output[=].valueCodeableConcept = EReferralWorkflowCS#onward-referral-request "Onward referral request"
* output[=].valueCodeableConcept.text = "Onward ServiceRequest created: ExampleERefServiceRequestOnward"

Instance: ExampleERefTaskCompleted
InstanceOf: ERefTask
Usage: #example
Title: "Example eReferral Task - Completed State"
Description: "Task representing a completed eReferral. Demonstrates full workflow closure with execution period and completion output."

* status = #completed
* businessStatus = EReferralWorkflowCS#accepted "Accepted"
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
* note[0].text = "New referral for patient with chest pain. Awaiting receiving-facility response."
* note[1].text = "Accepted by Manila General Hospital. Care navigator assigned."
* note[2].text = "Patient seen by Dr. Reyes. Angiography performed. Patient stable, discharged with medications."
* output[0].type = EReferralWorkflowCS#consultation-summary "Consultation summary"
* output[=].type.text = "Consultation summary"
* output[=].valueCodeableConcept = EReferralWorkflowCS#consultation-summary "Consultation summary"
* output[=].valueCodeableConcept.text = "Cardiology consultation completed. No acute coronary syndrome. Medication adjustment recommended."

// =============================================================================
// SUPPORTING RESOURCES (Self-Contained Pattern)
// Minimal instances required for the Task examples above
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

Instance: ExampleERefOrganizationOnwardReceiving
InstanceOf: PHCoreOrganization
Usage: #example
Title: "Example Onward Receiving Facility (for Task)"
Description: "Organization instance representing the alternate receiving facility for a referred-onward response."

* identifier.system = "http://fhir.nhdr.gov.ph/nhfr/hospcode"
* identifier.value = "DOH345678"
* name = "Eastern District Medical Center"
* type = $organization-type#prov "Healthcare Provider"
* address.line = "789 District Avenue"
* address.city = "Pasig City"
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
* performer = Reference(ExampleERefOrganizationReceiving)
* reasonCode = $sct#29857009 "Chest pain"
  * text = "Chest pain on exertion, suspected unstable angina"

Instance: ExampleERefServiceRequestOnward
InstanceOf: ERefServiceRequest
Usage: #example
Title: "Example Onward eReferral ServiceRequest"
Description: "ServiceRequest representing the onward referral created after the first receiving facility reports that capacity is full."

* status = #active
* intent = #order
* replaces = Reference(ExampleERefServiceRequestTask)
* code = $sct#183519001 "Referral to cardiology service"
* subject = Reference(ExampleERefPatientTask)
* authoredOn = "2025-03-15T10:15:00+08:00"
* requester = Reference(ExampleERefPractitionerRoleRequester)
* performer = Reference(ExampleERefOrganizationOnwardReceiving)
* reasonCode = $sct#29857009 "Chest pain"
  * text = "Chest pain on exertion, suspected unstable angina"
* note.text = "Onward referral after Manila General Hospital reported capacity full and recommended Eastern District Medical Center."
