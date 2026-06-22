Instance: ExampleERefCapabilityStatement
InstanceOf: ERefCapabilityStatement
Usage: #definition
Title: "PH eReferral Server CapabilityStatement"
Description: "CapabilityStatement for the PH eReferral Implementation Guide. Defines the conformance requirements for FHIR servers implementing the eReferral workflow. Validated at the June 2026 Aklan Connectathon with the Ana Reyes referral scenario (Kalibo Health Center -> Dr. Rafael S. Tumbokon Memorial Hospital)."

* name = "PHeReferralServerCapabilityStatement"
* version = "0.1.0"
* status = #draft
* experimental = true
* date = "2026-06-22"
* publisher = "SILab CoP IG Accelerator (eReferral)"
* description = "CapabilityStatement for the PH eReferral Implementation Guide. Defines the conformance requirements for FHIR servers implementing the eReferral workflow. Validated at the June 2026 Aklan Connectathon with the Ana Reyes referral scenario (Kalibo Health Center -> Dr. Rafael S. Tumbokon Memorial Hospital)."
* kind = #requirements
* fhirVersion = #4.0.1
* format[0] = #json
* format[+] = #xml

// =================================================================================
// REST Server Section
// =================================================================================
* rest[server].mode = #server
* rest[server].documentation = "FHIR RESTful server supporting the PH eReferral workflow lifecycle: create referral -> send -> receive -> respond -> close. Transaction Bundles are supported for atomic submission of referral packages. Conditional updates are used for master data (Patient, Practitioner, Organization, PractitionerRole) to enable idempotent upsert semantics. POST is used for clinical/business data (ServiceRequest, Task, Encounter, Condition, Observation, Procedure, Provenance)."

* rest[server].security.service = $restful-security-service#SMART-on-FHIR "SMART-on-FHIR"
* rest[server].security.description = "Implementations SHOULD use SMART on FHIR or equivalent bearer-token authentication. Transport security (TLS) is REQUIRED. See the PH Core IG security section for base requirements."

* rest[server].interaction[+].code = #transaction
* rest[server].interaction[=].documentation = "Transaction Bundle support for atomic submission of referral packages. The Ana Reyes example uses POST for clinical resources and conditional PUT for master data within a single transaction Bundle."

// =================================================================================
// Resource: Patient
// =================================================================================
* rest[server].resource[+].type = #Patient
* rest[server].resource[=].profile = "https://fhir.doh.gov.ph/pheref/StructureDefinition/ereferral-patient"
* rest[server].resource[=].documentation = "Patient demographics and identifiers for referral subjects. Uses PhilSys ID for conditional update matching. Must Support: name, gender, birthDate, telecom, address (PSGC), contact/next of kin."
* rest[server].resource[=].interaction[+].code = #read
* rest[server].resource[=].interaction[+].code = #search-type
* rest[server].resource[=].interaction[+].code = #create
* rest[server].resource[=].interaction[+].code = #update
* rest[server].resource[=].versioning = #no-version
* rest[server].resource[=].readHistory = false
* rest[server].resource[=].updateCreate = true
* rest[server].resource[=].conditionalUpdate = true
* rest[server].resource[=].conditionalDelete = #not-supported
* rest[server].resource[=].searchParam[+].name = "identifier"
* rest[server].resource[=].searchParam[=].type = #token
* rest[server].resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/Patient-identifier"
* rest[server].resource[=].searchParam[=].documentation = "Search by PhilSys ID or PhilHealth ID. Used for conditional update in transaction Bundles."
* rest[server].resource[=].searchParam[+].name = "name"
* rest[server].resource[=].searchParam[=].type = #string
* rest[server].resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/Patient-name"
* rest[server].resource[=].searchParam[=].documentation = "Search by patient name."
* rest[server].resource[=].searchParam[+].name = "birthdate"
* rest[server].resource[=].searchParam[=].type = #date
* rest[server].resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/individual-birthdate"
* rest[server].resource[=].searchParam[=].documentation = "Search by patient birth date."

// =================================================================================
// Resource: Practitioner
// =================================================================================
* rest[server].resource[+].type = #Practitioner
* rest[server].resource[=].profile = "https://fhir.doh.gov.ph/phcore/StructureDefinition/ph-core-practitioner"
* rest[server].resource[=].documentation = "Practitioner resource for referring and receiving clinicians. Uses PRC license number for conditional update matching."
* rest[server].resource[=].interaction[+].code = #read
* rest[server].resource[=].interaction[+].code = #search-type
* rest[server].resource[=].interaction[+].code = #create
* rest[server].resource[=].interaction[+].code = #update
* rest[server].resource[=].versioning = #no-version
* rest[server].resource[=].readHistory = false
* rest[server].resource[=].updateCreate = true
* rest[server].resource[=].conditionalUpdate = true
* rest[server].resource[=].conditionalDelete = #not-supported
* rest[server].resource[=].searchParam[+].name = "identifier"
* rest[server].resource[=].searchParam[=].type = #token
* rest[server].resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/Practitioner-identifier"
* rest[server].resource[=].searchParam[=].documentation = "Search by PRC license number. Used for conditional update in transaction Bundles."
* rest[server].resource[=].searchParam[+].name = "name"
* rest[server].resource[=].searchParam[=].type = #string
* rest[server].resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/Practitioner-name"
* rest[server].resource[=].searchParam[=].documentation = "Search by practitioner name."

// =================================================================================
// Resource: Organization
// =================================================================================
* rest[server].resource[+].type = #Organization
* rest[server].resource[=].profile = "https://fhir.doh.gov.ph/phcore/StructureDefinition/ph-core-organization"
* rest[server].resource[=].documentation = "Organization resource for referring and receiving healthcare facilities. Uses NHFR facility code for conditional update. Includes HCPN network identifier and PSGC-coded address."
* rest[server].resource[=].interaction[+].code = #read
* rest[server].resource[=].interaction[+].code = #search-type
* rest[server].resource[=].interaction[+].code = #create
* rest[server].resource[=].interaction[+].code = #update
* rest[server].resource[=].versioning = #no-version
* rest[server].resource[=].readHistory = false
* rest[server].resource[=].updateCreate = true
* rest[server].resource[=].conditionalUpdate = true
* rest[server].resource[=].conditionalDelete = #not-supported
* rest[server].resource[=].searchParam[+].name = "identifier"
* rest[server].resource[=].searchParam[=].type = #token
* rest[server].resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/Organization-identifier"
* rest[server].resource[=].searchParam[=].documentation = "Search by NHFR facility code. Used for conditional update in transaction Bundles."
* rest[server].resource[=].searchParam[+].name = "name"
* rest[server].resource[=].searchParam[=].type = #string
* rest[server].resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/Organization-name"
* rest[server].resource[=].searchParam[=].documentation = "Search by organization name."

// =================================================================================
// Resource: PractitionerRole
// =================================================================================
* rest[server].resource[+].type = #PractitionerRole
* rest[server].resource[=].profile = "https://fhir.doh.gov.ph/pheref/StructureDefinition/ereferral-practitioner-role"
* rest[server].resource[=].documentation = "PractitionerRole linking practitioners to facilities. Used for both sending context (referring practitioner) and receiving context (care navigator). Inherits PRC identifier from Practitioner for conditional update."
* rest[server].resource[=].interaction[+].code = #read
* rest[server].resource[=].interaction[+].code = #search-type
* rest[server].resource[=].interaction[+].code = #create
* rest[server].resource[=].interaction[+].code = #update
* rest[server].resource[=].versioning = #no-version
* rest[server].resource[=].readHistory = false
* rest[server].resource[=].updateCreate = true
* rest[server].resource[=].conditionalUpdate = true
* rest[server].resource[=].conditionalDelete = #not-supported
* rest[server].resource[=].searchParam[+].name = "identifier"
* rest[server].resource[=].searchParam[=].type = #token
* rest[server].resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/PractitionerRole-identifier"
* rest[server].resource[=].searchParam[=].documentation = "Search by identifier (inherited PRC license). Used for conditional update."
* rest[server].resource[=].searchParam[+].name = "practitioner"
* rest[server].resource[=].searchParam[=].type = #reference
* rest[server].resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/PractitionerRole-practitioner"
* rest[server].resource[=].searchParam[+].name = "organization"
* rest[server].resource[=].searchParam[=].type = #reference
* rest[server].resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/PractitionerRole-organization"

// =================================================================================
// Resource: ServiceRequest
// =================================================================================
* rest[server].resource[+].type = #ServiceRequest
* rest[server].resource[=].profile = "https://fhir.doh.gov.ph/pheref/StructureDefinition/ereferral-service-request"
* rest[server].resource[=].documentation = "Primary referral request resource. Central artifact linking patient, requester (via PractitionerRole), performer (receiving facility), reasonCode, reasonReference, and supportingInfo."
* rest[server].resource[=].interaction[+].code = #read
* rest[server].resource[=].interaction[+].code = #search-type
* rest[server].resource[=].interaction[+].code = #create
* rest[server].resource[=].versioning = #no-version
* rest[server].resource[=].readHistory = false
* rest[server].resource[=].updateCreate = false
* rest[server].resource[=].conditionalCreate = false
* rest[server].resource[=].conditionalUpdate = false
* rest[server].resource[=].conditionalDelete = #not-supported
* rest[server].resource[=].searchParam[+].name = "performer"
* rest[server].resource[=].searchParam[=].type = #reference
* rest[server].resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/ServiceRequest-performer"
* rest[server].resource[=].searchParam[=].documentation = "Search referrals by receiving facility. Used by receiving systems to find referrals directed to them."
* rest[server].resource[=].searchParam[+].name = "status"
* rest[server].resource[=].searchParam[=].type = #token
* rest[server].resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/ServiceRequest-status"
* rest[server].resource[=].searchParam[=].documentation = "Search referrals by status."
* rest[server].resource[=].searchParam[+].name = "subject"
* rest[server].resource[=].searchParam[=].type = #reference
* rest[server].resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/ServiceRequest-subject"
* rest[server].resource[=].searchParam[=].documentation = "Search referrals by patient."
* rest[server].resource[=].searchParam[+].name = "authored"
* rest[server].resource[=].searchParam[=].type = #date
* rest[server].resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/ServiceRequest-authored"
* rest[server].resource[=].searchParam[=].documentation = "Search by referral authored date."

// =================================================================================
// Resource: Task
// =================================================================================
* rest[server].resource[+].type = #Task
* rest[server].resource[=].profile = "https://fhir.doh.gov.ph/pheref/StructureDefinition/ereferral-task"
* rest[server].resource[=].documentation = "Workflow tracking resource for referral state management. Tracks progression: requested -> received -> accepted/rejected/referred-onward -> completed. Focus references the ServiceRequest."
* rest[server].resource[=].interaction[+].code = #read
* rest[server].resource[=].interaction[+].code = #search-type
* rest[server].resource[=].interaction[+].code = #create
* rest[server].resource[=].interaction[+].code = #update
* rest[server].resource[=].versioning = #no-version
* rest[server].resource[=].readHistory = false
* rest[server].resource[=].updateCreate = false
* rest[server].resource[=].conditionalCreate = false
* rest[server].resource[=].conditionalUpdate = false
* rest[server].resource[=].conditionalDelete = #not-supported
* rest[server].resource[=].searchParam[+].name = "focus"
* rest[server].resource[=].searchParam[=].type = #reference
* rest[server].resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/Task-focus"
* rest[server].resource[=].searchParam[=].documentation = "Search tasks by the ServiceRequest they track. Example: GET /Task?focus=ServiceRequest/{id}"
* rest[server].resource[=].searchParam[+].name = "status"
* rest[server].resource[=].searchParam[=].type = #token
* rest[server].resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/Task-status"
* rest[server].resource[=].searchParam[=].documentation = "Search tasks by workflow status."
* rest[server].resource[=].searchParam[+].name = "owner"
* rest[server].resource[=].searchParam[=].type = #reference
* rest[server].resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/Task-owner"
* rest[server].resource[=].searchParam[=].documentation = "Search tasks by assigned owner (receiving facility or care navigator)."
* rest[server].resource[=].searchParam[+].name = "requester"
* rest[server].resource[=].searchParam[=].type = #reference
* rest[server].resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/Task-requester"
* rest[server].resource[=].searchParam[=].documentation = "Search tasks by the requester."
* rest[server].resource[=].searchParam[+].name = "patient"
* rest[server].resource[=].searchParam[=].type = #reference
* rest[server].resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/Task-patient"
* rest[server].resource[=].searchParam[=].documentation = "Search tasks by patient."

// =================================================================================
// Resource: Encounter
// =================================================================================
* rest[server].resource[+].type = #Encounter
* rest[server].resource[=].profile = "https://fhir.doh.gov.ph/pheref/StructureDefinition/ereferral-encounter"
* rest[server].resource[=].documentation = "Encounter documenting clinical visit context for referral activities. Used for both initiating encounter and receiving (closure) encounter. basedOn references the ServiceRequest."
* rest[server].resource[=].interaction[+].code = #read
* rest[server].resource[=].interaction[+].code = #search-type
* rest[server].resource[=].interaction[+].code = #create
* rest[server].resource[=].versioning = #no-version
* rest[server].resource[=].readHistory = false
* rest[server].resource[=].updateCreate = false
* rest[server].resource[=].conditionalCreate = false
* rest[server].resource[=].conditionalUpdate = false
* rest[server].resource[=].conditionalDelete = #not-supported
* rest[server].resource[=].searchParam[+].name = "subject"
* rest[server].resource[=].searchParam[=].type = #reference
* rest[server].resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/Encounter-subject"
* rest[server].resource[=].searchParam[+].name = "based-on"
* rest[server].resource[=].searchParam[=].type = #reference
* rest[server].resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/Encounter-based-on"

// =================================================================================
// Resource: Condition
// =================================================================================
* rest[server].resource[+].type = #Condition
* rest[server].resource[=].profile = "https://fhir.doh.gov.ph/pheref/StructureDefinition/ereferral-condition"
* rest[server].resource[=].documentation = "Condition resource for diagnoses and problems. Used for chief complaint (problem-list-item) and working impression (encounter-diagnosis). Linked to encounter."
* rest[server].resource[=].interaction[+].code = #read
* rest[server].resource[=].interaction[+].code = #search-type
* rest[server].resource[=].interaction[+].code = #create
* rest[server].resource[=].versioning = #no-version
* rest[server].resource[=].readHistory = false
* rest[server].resource[=].updateCreate = false
* rest[server].resource[=].conditionalCreate = false
* rest[server].resource[=].conditionalUpdate = false
* rest[server].resource[=].conditionalDelete = #not-supported
* rest[server].resource[=].searchParam[+].name = "subject"
* rest[server].resource[=].searchParam[=].type = #reference
* rest[server].resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/Condition-subject"
* rest[server].resource[=].searchParam[+].name = "encounter"
* rest[server].resource[=].searchParam[=].type = #reference
* rest[server].resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/Condition-encounter"

// =================================================================================
// Resource: Observation
// =================================================================================
* rest[server].resource[+].type = #Observation
* rest[server].resource[=].profile = "https://fhir.doh.gov.ph/pheref/StructureDefinition/ereferral-observation"
* rest[server].resource[=].documentation = "Clinical observation resource for vital signs, lab results, and clinical measurements. Supports BP, heart rate, respiratory rate, SpO2, temperature, weight."
* rest[server].resource[=].interaction[+].code = #read
* rest[server].resource[=].interaction[+].code = #search-type
* rest[server].resource[=].interaction[+].code = #create
* rest[server].resource[=].versioning = #no-version
* rest[server].resource[=].readHistory = false
* rest[server].resource[=].updateCreate = false
* rest[server].resource[=].conditionalCreate = false
* rest[server].resource[=].conditionalUpdate = false
* rest[server].resource[=].conditionalDelete = #not-supported
* rest[server].resource[=].searchParam[+].name = "subject"
* rest[server].resource[=].searchParam[=].type = #reference
* rest[server].resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/Observation-subject"
* rest[server].resource[=].searchParam[+].name = "encounter"
* rest[server].resource[=].searchParam[=].type = #reference
* rest[server].resource[=].searchParam[+].name = "code"
* rest[server].resource[=].searchParam[=].type = #token

// =================================================================================
// Resource: Provenance
// =================================================================================
* rest[server].resource[+].type = #Provenance
* rest[server].resource[=].profile = "https://fhir.doh.gov.ph/pheref/StructureDefinition/ereferral-provenance"
* rest[server].resource[=].documentation = "Provenance resource for audit trail and signature attestation. Targets the ServiceRequest. Records author, timestamp, and professional signature."
* rest[server].resource[=].interaction[+].code = #read
* rest[server].resource[=].interaction[+].code = #search-type
* rest[server].resource[=].interaction[+].code = #create
* rest[server].resource[=].versioning = #no-version
* rest[server].resource[=].readHistory = false
* rest[server].resource[=].updateCreate = false
* rest[server].resource[=].conditionalCreate = false
* rest[server].resource[=].conditionalUpdate = false
* rest[server].resource[=].conditionalDelete = #not-supported
* rest[server].resource[=].searchParam[+].name = "target"
* rest[server].resource[=].searchParam[=].type = #reference
* rest[server].resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/Provenance-target"

// =================================================================================
// Resource: RelatedPerson
// =================================================================================
* rest[server].resource[+].type = #RelatedPerson
* rest[server].resource[=].profile = "https://fhir.doh.gov.ph/pheref/StructureDefinition/ereferral-related-person"
* rest[server].resource[=].documentation = "RelatedPerson for patient contacts, next of kin, guardians, and accompanying persons. Optional resource for separate contact details."
* rest[server].resource[=].interaction[+].code = #read
* rest[server].resource[=].interaction[+].code = #search-type
* rest[server].resource[=].interaction[+].code = #create
* rest[server].resource[=].versioning = #no-version
* rest[server].resource[=].readHistory = false
* rest[server].resource[=].updateCreate = false
* rest[server].resource[=].conditionalCreate = false
* rest[server].resource[=].conditionalUpdate = false
* rest[server].resource[=].conditionalDelete = #not-supported
* rest[server].resource[=].searchParam[+].name = "patient"
* rest[server].resource[=].searchParam[=].type = #reference
* rest[server].resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/RelatedPerson-patient"

// =================================================================================
// Resource: Procedure
// =================================================================================
* rest[server].resource[+].type = #Procedure
* rest[server].resource[=].profile = "https://fhir.doh.gov.ph/pheref/StructureDefinition/ereferral-procedure"
* rest[server].resource[=].documentation = "Procedure resource for treatments and procedures before or during the referral. Linked to encounter."
* rest[server].resource[=].interaction[+].code = #read
* rest[server].resource[=].interaction[+].code = #search-type
* rest[server].resource[=].interaction[+].code = #create
* rest[server].resource[=].versioning = #no-version
* rest[server].resource[=].readHistory = false
* rest[server].resource[=].updateCreate = false
* rest[server].resource[=].conditionalCreate = false
* rest[server].resource[=].conditionalUpdate = false
* rest[server].resource[=].conditionalDelete = #not-supported
* rest[server].resource[=].searchParam[+].name = "subject"
* rest[server].resource[=].searchParam[=].type = #reference
* rest[server].resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/Procedure-subject"
* rest[server].resource[=].searchParam[+].name = "encounter"
* rest[server].resource[=].searchParam[=].type = #reference

// =================================================================================
// Resource: MedicationAdministration
// =================================================================================
* rest[server].resource[+].type = #MedicationAdministration
* rest[server].resource[=].profile = "https://fhir.doh.gov.ph/pheref/StructureDefinition/ereferral-medication-administration"
* rest[server].resource[=].documentation = "MedicationAdministration for documenting medications administered. Linked to encounter for clinical context."
* rest[server].resource[=].interaction[+].code = #read
* rest[server].resource[=].interaction[+].code = #search-type
* rest[server].resource[=].interaction[+].code = #create
* rest[server].resource[=].versioning = #no-version
* rest[server].resource[=].readHistory = false
* rest[server].resource[=].updateCreate = false
* rest[server].resource[=].conditionalCreate = false
* rest[server].resource[=].conditionalUpdate = false
* rest[server].resource[=].conditionalDelete = #not-supported
* rest[server].resource[=].searchParam[+].name = "subject"
* rest[server].resource[=].searchParam[=].type = #reference
* rest[server].resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/MedicationAdministration-subject"
* rest[server].resource[=].searchParam[+].name = "context"
* rest[server].resource[=].searchParam[=].type = #reference
* rest[server].resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/MedicationAdministration-context"

// =================================================================================
// Resource: Immunization
// =================================================================================
* rest[server].resource[+].type = #Immunization
* rest[server].resource[=].profile = "https://fhir.doh.gov.ph/pheref/StructureDefinition/ereferral-immunization"
* rest[server].resource[=].documentation = "Immunization resource for vaccination history as clinical context in referrals."
* rest[server].resource[=].interaction[+].code = #read
* rest[server].resource[=].interaction[+].code = #search-type
* rest[server].resource[=].interaction[+].code = #create
* rest[server].resource[=].versioning = #no-version
* rest[server].resource[=].readHistory = false
* rest[server].resource[=].updateCreate = false
* rest[server].resource[=].conditionalCreate = false
* rest[server].resource[=].conditionalUpdate = false
* rest[server].resource[=].conditionalDelete = #not-supported
* rest[server].resource[=].searchParam[+].name = "patient"
* rest[server].resource[=].searchParam[=].type = #reference
* rest[server].resource[=].searchParam[+].name = "vaccine-code"
* rest[server].resource[=].searchParam[=].type = #token
* rest[server].resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/Immunization-vaccine-code"

// =================================================================================
// Resource: DiagnosticReport
// =================================================================================
* rest[server].resource[+].type = #DiagnosticReport
* rest[server].resource[=].profile = "http://hl7.org/fhir/StructureDefinition/DiagnosticReport"
* rest[server].resource[=].documentation = "DiagnosticReport for laboratory results and diagnostic studies. Currently uses base FHIR profile."
* rest[server].resource[=].interaction[+].code = #read
* rest[server].resource[=].interaction[+].code = #search-type
* rest[server].resource[=].interaction[+].code = #create
* rest[server].resource[=].versioning = #no-version
* rest[server].resource[=].readHistory = false
* rest[server].resource[=].updateCreate = false
* rest[server].resource[=].conditionalCreate = false
* rest[server].resource[=].conditionalUpdate = false
* rest[server].resource[=].conditionalDelete = #not-supported
* rest[server].resource[=].searchParam[+].name = "subject"
* rest[server].resource[=].searchParam[=].type = #reference
* rest[server].resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/DiagnosticReport-subject"
* rest[server].resource[=].searchParam[+].name = "encounter"
* rest[server].resource[=].searchParam[=].type = #reference
