Instance: ExampleERefEncounter
InstanceOf: ERefEncounter
Usage: #example
Title: "Example eReferral Encounter"
Description: "An example encounter for a cardiology referral, where a patient is received at a tertiary hospital based on a referral from a rural health unit."

* identifier.system = "urn://example.com/ph-ereferral/encounter-id"
* identifier.value = "ENC-2025-001234"

* status = #finished

* statusHistory[0].status = #planned
* statusHistory[=].period.start = "2025-03-15T09:30:00+08:00"
* statusHistory[=].period.end = "2025-03-16T07:59:00+08:00"
* statusHistory[+].status = #arrived
* statusHistory[=].period.start = "2025-03-16T08:00:00+08:00"
* statusHistory[=].period.end = "2025-03-16T08:15:00+08:00"
* statusHistory[+].status = #in-progress
* statusHistory[=].period.start = "2025-03-16T08:15:00+08:00"
* statusHistory[=].period.end = "2025-03-16T10:30:00+08:00"
* statusHistory[+].status = #finished
* statusHistory[=].period.start = "2025-03-16T10:30:00+08:00"
* statusHistory[=].period.end = "2025-03-16T10:30:00+08:00"

* class = $v3-ActCode#AMB "ambulatory"

* classHistory[0].class = $v3-ActCode#AMB "ambulatory"
* classHistory[=].period.start = "2025-03-16T08:00:00+08:00"
* classHistory[=].period.end = "2025-03-16T10:30:00+08:00"

* type = $sct#11429006 "Consultation"

* priority = $sct#25876001 "Emergency"

* subject = Reference(ExampleERefPatient)

* basedOn = Reference(ExampleERefServiceRequest)

* participant[0].type = http://terminology.hl7.org/CodeSystem/v3-ParticipationType#CON "consultant"
* participant[=].individual = Reference(ExampleERefPractitionerRole)
* participant[=].period.start = "2025-03-16T08:15:00+08:00"
* participant[=].period.end = "2025-03-16T10:30:00+08:00"
* participant[+].type = http://terminology.hl7.org/CodeSystem/v3-ParticipationType#ATND "attender"
// participant[=].individual = Reference(ExampleERefRelatedPerson) TO DO - Rationale: RelatedPerson profile still unavailable.
* participant[=].individual.display = "Mrs. Dela Cruz" //Temporary display until RelatedPerson profile is available.
* participant[=].period.start = "2025-03-16T08:00:00+08:00"
* participant[=].period.end = "2025-03-16T10:30:00+08:00"

* period.start = "2025-03-16T08:00:00+08:00"
* period.end = "2025-03-16T10:30:00+08:00"

* reasonCode = $sct#29857009 "Chest pain"
  * text = "Chest pain on exertion, suspected unstable angina"

* reasonReference = Reference(ExampleERefConditionChestPain)

* diagnosis[0].condition = Reference(ExampleERefConditionChestPain)
* diagnosis[=].use = $sct#89100005 "Final diagnosis (discharge)"

* location[0].location.display = "Cardiology Outpatient Clinic"
* location[=].status = #completed
* location[=].period.start = "2025-03-16T08:00:00+08:00"
* location[=].period.end = "2025-03-16T10:30:00+08:00"
