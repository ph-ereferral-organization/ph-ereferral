Profile: ERefCapabilityStatement
Parent: CapabilityStatement
Id: ereferral-capability-statement
Title: "PH eReferral CapabilityStatement"
Description: "CapabilityStatement for the PH eReferral Implementation Guide. Defines the conformance requirements for FHIR servers implementing the eReferral workflow, including supported resource types, profiles, RESTful interactions, search parameters, and security expectations. Validated during the June 2026 Aklan Connectathon."

* status 1..1
* status = #draft
* kind 1..1
* kind = #requirements
* fhirVersion = #4.0.1
* format 1..*

* rest 1..*
* rest ^slicing.discriminator.type = #value
* rest ^slicing.discriminator.path = "mode"
* rest ^slicing.rules = #open
* rest contains server 1..1
* rest[server].mode = #server (exactly)
* rest[server].security 1..1
* rest[server].security insert ObligationRequired
* rest[server].interaction 1..*
* rest[server].resource 1..*
* rest[server].resource.profile 1..1
* rest[server].resource.interaction 1..*

Invariant: ereferral-cs-1
Description: "Server rest entry must declare transaction interaction"
Severity: #error
Expression: "rest.all(mode = 'server' implies interaction.where(code = 'transaction').exists())"
