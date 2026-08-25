Profile: ERefProcedure
Parent: PHCoreProcedure
Id: ereferral-procedure
Title: "EReferral Procedure"
Description: "Procedure profile for procedures performed or documented as part of the clinical context of a Philippine eReferral."

* subject MS
* subject insert ObligationOptional
* subject only Reference(ERefPatient)

* encounter MS
* encounter insert ObligationOptional
* encounter only Reference(ERefEncounter)

* reasonReference only Reference(ERefCondition or ERefObservation or ERefProcedure)

* note MS
