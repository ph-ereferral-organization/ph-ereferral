Profile: ERefProcedure
Parent: PHCoreProcedure
Id: ereferral-procedure
Title: "EReferral Procedure"
Description: "Procedure profile for procedures performed or documented as part of the clinical context of a Philippine eReferral."

* status MS

* category MS

* code MS

* subject MS
* subject only Reference(ERefPatient)

* encounter MS
* encounter only Reference(ERefEncounter)

* performed[x] MS

* performer MS

* performer.actor MS

* reasonCode MS

* reasonReference MS
* reasonReference only Reference(PHCoreCondition or PHCoreObservation or ERefProcedure)

* note MS
