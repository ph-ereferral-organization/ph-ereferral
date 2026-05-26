Alias: $sct = http://snomed.info/sct
Alias: $loinc = http://loinc.org
Alias: $icd11 = http://id.who.int/icd/release/11/mms
Alias: $VaccineAdministeredCodeSet-CVX = http://hl7.org/fhir/sid/cvx
Alias: $PhilHealthID = http://philhealth.gov.ph/fhir/Identifier/philhealth-id
Alias: $PhilSysID = http://philsys.gov.ph/fhir/Identifier/philsys-id
Alias: $PSA = https://psa.gov.ph/classification
Alias: $PSCED = https://psa.gov.ph/classification/psced/level
Alias: $PSGC = https://psa.gov.ph/classification/psgc
Alias: $PSOC = https://psa.gov.ph/classification/psoc/unit
Alias: $v2-0203 = http://terminology.hl7.org/CodeSystem/v2-0203
Alias: $v3-ActCode = http://terminology.hl7.org/CodeSystem/v3-ActCode
Alias: $condition-clinical = http://terminology.hl7.org/CodeSystem/condition-clinical
Alias: $observation-category = http://terminology.hl7.org/CodeSystem/observation-category
Alias: $v3-ObservationInterpretation = http://terminology.hl7.org/CodeSystem/v3-ObservationInterpretation
Alias: $allergyintolerance-clinical = http://terminology.hl7.org/CodeSystem/allergyintolerance-clinical
Alias: $v3-roleCode = http://terminology.hl7.org/CodeSystem/v3-RoleCode
Alias: $sht = https://icd.who.int/browse10/2019/en#
Alias: $request-priority = http://hl7.org/fhir/request-priority
Alias: $servicerequest-status-reason = http://hl7.org/fhir/service-request-status-reason
Alias: $organization-type = http://terminology.hl7.org/CodeSystem/organization-type
Alias: $provenance-participant-type = http://terminology.hl7.org/CodeSystem/provenance-participant-type
Alias: $signature-type = urn:iso-astm:E1762-95:2013

// Obligation extension
Alias: $obligation = http://hl7.org/fhir/StructureDefinition/obligation

// PH Core ActorDefinitions for obligations (reused from PH Core IG dependency)
// Using lowercase aliases with $ prefix (like EU EPS) for concise RuleSet usage
// These resolve to full canonical URLs required by the obligation extension
// PH eReferral depends on fhir.ph.core, so these ActorDefinitions are available
Alias: $server = https://fhir.doh.gov.ph/phcore/ActorDefinition/Server
Alias: $consumer = https://fhir.doh.gov.ph/phcore/ActorDefinition/Consumer
Alias: $creator = https://fhir.doh.gov.ph/phcore/ActorDefinition/Creator