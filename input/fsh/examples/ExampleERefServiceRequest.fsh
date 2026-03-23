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
