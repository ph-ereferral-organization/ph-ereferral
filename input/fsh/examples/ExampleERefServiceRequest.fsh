Instance: ExampleERefServiceRequest
InstanceOf: ERefServiceRequest
Usage: #example
Title: "Example eReferral Service Request"
Description: "An example referral request from a rural health unit to a tertiary hospital for cardiology consultation."
* status = #active
* intent = #order
* category = $sct#103695009 "Referral to specialist"
* priority = #urgent
* code = $sct#183519001 "Referral to cardiology service"
* subject = Reference(ExampleERefPatient)
* authoredOn = "2025-03-15T09:30:00+08:00"
* requester = Reference(ExampleERefPractitionerRole)
* performer = Reference(ExampleERefReceivingHospital)
* reasonCode = $sct#29857009 "Chest pain"
  * text = "Chest pain on exertion, suspected unstable angina"
* reasonReference = Reference(ExampleERefConditionChestPain)
* supportingInfo[0] = Reference(ExampleERefObservationBP)
* supportingInfo[+] = Reference(ExampleERefObservationECG)
* note.text = "Patient reports chest pain on exertion for 3 days. ECG shows ST depression. Please evaluate for possible PCI. Patient has no known drug allergies."
* occurrenceDateTime = "2025-03-16T08:00:00+08:00"
* requisition.system = "urn:oid:1.2.840.113619.21.1.2"
* requisition.value = "REF-2025-001234"

// Supporting instances for the example

Instance: ExampleERefPatient
InstanceOf: Patient
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

Instance: ExampleERefPractitionerRole
InstanceOf: PractitionerRole
Usage: #example
Title: "Example Referring Practitioner Role"
Description: "Example referring practitioner with role and organization"
* identifier.system = "urn:oid:2.16.840.1.113883.2.9.4.3.3"
* identifier.value = "MD-98765"
* active = true
* practitioner = Reference(ExampleERefPractitioner)
* organization = Reference(ExampleERefReferringFacility)
* code = $v3-roleCode#CP "Consulting Physician"
* specialty = $sct#419192003 "Internal medicine"
* telecom.system = #phone
* telecom.value = "+63 2 8123 4567"
* telecom.use = #work

Instance: ExampleERefPractitioner
InstanceOf: Practitioner
Usage: #example
Title: "Example Referring Practitioner"
Description: "Example referring practitioner"
* identifier.system = "urn:oid:2.16.840.1.113883.2.9.4.3.3"
* identifier.value = "MD-98765"
* name.use = #official
* name.family = "Santos"
* name.given[0] = "Maria"
* name.given[+] = "Clara"
* name.prefix = "Dr."
* gender = #female
* qualification.code = $sct#1062931000119102 "Doctor of Medicine"

Instance: ExampleERefReferringFacility
InstanceOf: Organization
Usage: #example
Title: "Example Referring RHU"
Description: "Example Rural Health Unit referring facility"
* identifier.system = "urn:oid:2.16.840.1.113883.2.9.4.1.1"
* identifier.value = "RHU-QC-042"
* active = true
* type = $organization-type#prov "Healthcare Provider"
* name = "Batasan Hills Rural Health Unit"
* address.line = "Batasan Road"
* address.city = "Quezon City"
* address.state = "Metro Manila"
* address.postalCode = "1126"
* address.country = "PH"

Instance: ExampleERefReceivingHospital
InstanceOf: Organization
Usage: #example
Title: "Example Receiving Hospital"
Description: "Example tertiary hospital receiving facility"
* identifier.system = "urn:oid:2.16.840.1.113883.2.9.4.1.1"
* identifier.value = "HOSP-QC-001"
* active = true
* type = $organization-type#hospt "Hospital"
* name = "Philippine Heart Center"
* address.line = "East Avenue"
* address.city = "Quezon City"
* address.state = "Metro Manila"
* address.postalCode = "1100"
* address.country = "PH"

Instance: ExampleERefConditionChestPain
InstanceOf: Condition
Usage: #example
Title: "Example Condition - Chest Pain"
Description: "Example chest pain condition for referral"
* clinicalStatus = $condition-clinical#active
* verificationStatus = $sct#provisional "Provisional"
* category = $sct#439401001 "Diagnosis"
* severity = $sct#24484000 "Severe"
* code = $sct#29857009 "Chest pain"
  * text = "Chest pain on exertion"
* subject = Reference(ExampleERefPatient)
* onsetDateTime = "2025-03-12"

Instance: ExampleERefObservationBP
InstanceOf: Observation
Usage: #example
Title: "Example Blood Pressure Observation"
Description: "Example vital signs for referral"
* status = #final
* category = $observation-category#vital-signs
* code = $loinc#85354-9 "Blood pressure panel with all children optional"
* subject = Reference(ExampleERefPatient)
* effectiveDateTime = "2025-03-15T09:15:00+08:00"
* component[0].code = $loinc#8480-6 "Systolic blood pressure"
* component[=].valueQuantity = 160 'mm[Hg]' "mmHg"
* component[+].code = $loinc#8462-4 "Diastolic blood pressure"
* component[=].valueQuantity = 95 'mm[Hg]' "mmHg"

Instance: ExampleERefObservationECG
InstanceOf: Observation
Usage: #example
Title: "Example ECG Observation"
Description: "Example ECG findings for referral"
* status = #final
* category = $observation-category#procedure
* code = $loinc#11524-6 "EKG study"
* subject = Reference(ExampleERefPatient)
* effectiveDateTime = "2025-03-15T09:20:00+08:00"
* valueString = "ST depression in leads V4-V6, T wave inversion in lead III"
* interpretation = $v3-ObservationInterpretation#A "Abnormal"
