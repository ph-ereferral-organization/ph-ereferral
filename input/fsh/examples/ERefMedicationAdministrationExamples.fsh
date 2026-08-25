// Supporting resources defined in ERefInitiatingFacilityBundle.fsh:
//   - ExampleERefPatient

Instance: ExampleERefMedicationAdministrationAntibiotic
InstanceOf: ERefMedicationAdministration
Usage: #example
Title: "Example Antibiotic Administration"
Description: "Example IV antibiotic administration for a patient with suspected infection. Demonstrates REF-39 Treatment Given data element."

* status = #completed
* medicationReference = Reference(ExampleERefMedicationAntibiotic)
* subject = Reference(ExampleERefPatient)
* effectivePeriod.start = "2026-06-18T08:00:00+08:00"
* effectivePeriod.end = "2026-06-18T08:30:00+08:00"
* performer.actor = Reference(ExampleERefPractitionerSubmission)
* performer.function = $sct#158965000 "Medical practitioner"
* dosage.site = $sct#49852007 "Structure of median cubital vein"
* dosage.route = $sct#47625008 "Intravenous route"
* dosage.dose = 750 'mg' "mg"
* note.text = "Administered as part of pre-referral treatment for suspected sepsis."

Instance: ExampleERefMedicationAdministrationChronic
InstanceOf: ERefMedicationAdministration
Usage: #example
Title: "Example Chronic Medication Administration"
Description: "Example chronic medication administration (antihypertensive) demonstrating routine medication given to patient."

* status = #completed
* medicationReference = Reference(ExampleERefMedicationTwinact)
* subject = Reference(ExampleERefPatient)
* effectiveDateTime = "2026-06-18T07:00:00+08:00"
// context removed — ExampleERefEncounter does not exist yet. Can be restored when encounter example is created.
* performer.actor = Reference(ExampleERefPractitionerSubmission)
* performer.function = $sct#158965000 "Medical practitioner"
* dosage.route = $sct#26643006 "Oral route"
* dosage.dose = 1 '{tablet}' "tablet"
* note.text = "Patient's regular morning antihypertensive medication given before referral."

Instance: ExampleERefMedicationAntibiotic
InstanceOf: PHCoreMedication
Usage: #example
Title: "Example Cefuroxime Medication"
Description: "Example antibiotic medication resource for IV administration."

* code = $sct#105590001 "Substance"
* code.text = "Cefuroxime 750mg IV (antibiotic)"
* status = #active

Instance: ExampleERefMedicationTwinact
InstanceOf: PHCoreMedication
Usage: #example
Title: "Example Twinact Medication"
Description: "Example medication resource for Twinact (Telmisartan + Amlodipine) used in chronic medication administration example."

* code = $sct#105590001 "Substance"
* code.text = "Twinact (Telmisartan 80mg + Amlodipine 5mg) - antihypertensive"
* status = #active
