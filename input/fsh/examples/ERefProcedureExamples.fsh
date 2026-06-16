Instance: ExampleERefProcedureECG
InstanceOf: ERefProcedure
Usage: #example
Title: "Example Procedure - Electrocardiogram"
Description: "Example diagnostic procedure documented as supporting clinical information for referral."

* status = #completed
* category = $sct#103693007 "Diagnostic procedure"
* code = $sct#29303009 "Electrocardiographic procedure"
* subject = Reference(ExampleERefPatient)
* performedDateTime = "2025-03-15T09:15:00+08:00"
* performer.actor = Reference(ExampleERefPractitionerRole)
* performer.function = $sct#158965000 "Medical practitioner"
* reasonCode = $sct#29857009 "Chest pain"
* reasonReference = Reference(ExampleERefConditionChestPain)
* note.text = "ECG was performed prior to referral to support clinical assessment of chest pain."

Instance: ExampleERefProcedureInitialManagement
InstanceOf: ERefProcedure
Usage: #example
Title: "Example Procedure - Initial Management"
Description: "Example therapeutic procedure or intervention performed before referral."

* status = #completed
* category.text = "Therapeutic procedure"
* code.text = "Initial stabilization and symptom management"
* subject = Reference(ExampleERefPatient)
* performedPeriod.start = "2025-03-15T08:45:00+08:00"
* performedPeriod.end = "2025-03-15T09:10:00+08:00"
* performer.actor = Reference(ExampleERefPractitionerRole)
* performer.function = $sct#158965000 "Medical practitioner"
* reasonCode = $sct#29857009 "Chest pain"
* reasonReference = Reference(ExampleERefConditionChestPain)
* note.text = "Initial management was provided before referral, including monitoring, symptom control, and preparation for transfer."
