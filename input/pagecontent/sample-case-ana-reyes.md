# Sample Case: Ana Reyes eReferral — Initiation and Workflow Tutorial

> **Target Audience:** Connectathon participants, implementers, and developers learning how to create, send, and trace an eReferral using the PH eReferral IG profiles against a FHIR server.
>
> **Prerequisite:** Familiarity with basic FHIR concepts (resources, references, Bundles). If you are new to FHIR, read [What is FHIR?](https://www.hl7.org/fhir/overview.html) first.

**Test Server (REST API):** `https://cdr.fhirlab.net/fhir`  
**Terminology Server (Code Lookup):** `https://tx.fhirlab.net/fhir`

This tutorial walks you through the complete eReferral initiation workflow using a **FHIR transaction Bundle**. You will learn how to submit a referral with conditional PUT for master data and POST for clinical data, and how to trace the referral through task state progression.

---

## Table of Contents

1. [The Case Scenario](#the-case-scenario)
2. [Reference Rules in This Bundle](#reference-rules-in-this-bundle)
3. [Looking Up Codes at tx.fhirlab.net](#looking-up-codes-at-txfhirlabnet)
4. [The Transaction Bundle](#the-transaction-bundle)
5. [Reading Back Resources](#reading-back-resources)
6. [Searching for Referrals](#searching-for-referrals)
7. [Tracing the Workflow — Task State Progression](#tracing-the-workflow--task-state-progression)
8. [Complete cURL Commands](#complete-curl-commands)
9. [Key Takeaways](#key-takeaways)
10. [Links to Rendered Artifacts](#links-to-rendered-artifacts)

---

## The Case Scenario

**Ana Luisa Reyes**, a 38-year-old pregnant woman (G2P1, 32 weeks AOG), presents to **Kalibo Health Center (KHC)** with severe headache, dizziness, blurring of vision, chest tightness, and epigastric pain persisting for two days.

### Clinical Summary

| Detail | Value |
|--------|-------|
| **Patient** | Ana Luisa Reyes, 38F, DOB 12 March 1988 |
| **Address** | Area 4, Barangay Mabuhay, Kalibo, Aklan |
| **PhilHealth ID** | 78-658064775-3 |
| **PhilSys ID** | 7731-0812-4491-0326 |
| **Blood Pressure** | 180/110 mmHg (Severe Hypertension) |
| **Heart Rate** | 112 bpm |
| **Respiratory Rate** | 24/min |
| **SpO₂** | 96% |
| **Temperature** | 36.8°C |
| **Weight** | 72 kg |
| **Laboratory** | Urinalysis: Proteinuria 3+ |
| **Working Impression** | G2P1(1001), Pregnancy Uterine, 32 weeks AOG — Severe Pre-eclampsia |
| **Initial Treatment** | Methyldopa 250mg BID, Folic Acid 5mg OD, FeSO₄ 300mg OD, CaCO₃ 500mg TID |
| **Referring Provider** | Dr. Maria Villanueva, Primary Care Physician |
| **Referring Facility** | Kalibo Health Center (NHFR: 3056) |
| **Receiving Facility** | Dr. Rafael S. Tumbokon Memorial Hospital — DRSTMH (NHFR: 513) |
| **Receiving Practitioner** | Dr. Carlos Lim, Care Navigator (PRC: 7890123) |
| **Referral Category** | Emergency |
| **Reason Category** | Procedure |
{:.ph-table}

### What This Referral Models

This is a **referral initiation** — the moment Kalibo Health Center determines Ana needs higher-level care and sends the referral to DRSTMH. It is modeled as a **FHIR transaction Bundle** containing 20 entries that together form a complete, self-contained referral payload.

---

### Reference Rules in This Bundle

- Every clinical resource points to the **Patient** via `subject` and the **Encounter** via `encounter`
- The **ServiceRequest** (`requester`) points to the referring facility's PractitionerRole
- The **ServiceRequest** (`performer`) points to the receiving facility's PractitionerRole
- The **Task** (`focus`) points to the ServiceRequest and (`owner`) points to the receiving PractitionerRole
- The **Provenance** (`target`) attests to the ServiceRequest
- All intra-Bundle references use `urn:uuid:` identifiers matching the bundle entry `fullUrl` values

---

## Looking Up Codes at tx.fhirlab.net

The eReferral IG uses codes from multiple terminology systems. Here is how to verify them interactively.

### Terminology Systems Used

| System URL | Name | What It Codes |
|------------|------|---------------|
| `http://snomed.info/sct` | SNOMED CT | Clinical findings, procedures, body sites |
| `http://loinc.org` | LOINC | Observations, lab panels, document types |
| `https://psa.gov.ph/classification/psgc` | PSGC | Philippine geographic codes (region, province, city, barangay) |
| `http://philhealth.gov.ph/fhir/Identifier/philhealth-id` | PhilHealth ID | National health insurance identifiers |
| `http://philsys.gov.ph/fhir/Identifier/philsys-id` | PhilSys ID | National identification system |
| `http://terminology.hl7.org/CodeSystem/condition-clinical` | Condition Clinical Status | active, recurrence, relapse, inactive, remission, resolved |
| `http://terminology.hl7.org/CodeSystem/condition-ver-status` | Condition Verification | unconfirmed, provisional, differential, confirmed, refuted, entered-in-error |
| `http://terminology.hl7.org/CodeSystem/condition-category` | Condition Category | problem-list-item, encounter-diagnosis |
| `http://terminology.hl7.org/CodeSystem/observation-category` | Observation Category | vital-signs, laboratory, imaging, survey, etc. |
| `http://terminology.hl7.org/CodeSystem/v3-ActCode` | HL7 v3 ActCode | Encounter class (AMB, EMER, IMP, etc.) |
| `http://terminology.hl7.org/CodeSystem/v3-RoleCode` | HL7 v3 RoleCode | Contact relationships (HUSB, WIFE, etc.) |
| `http://terminology.hl7.org/CodeSystem/v3-DataOperation` | HL7 v3 DataOperation | Provenance activity (CREATE, UPDATE, etc.) |
| `urn:iso-astm:E1762-95:2013` | Signature Type Codes | Digital signature types |
{:.ph-table}

### Code Lookup Commands

Look up a SNOMED CT concept by code:

```bash
curl -s "https://tx.fhirlab.net/fhir/CodeSystem/\$lookup?system=http://snomed.info/sct&code=398254007" \
  -H "Accept: application/fhir+json" | jq .
```

This returns the display name and properties for "Pre-eclampsia" (SNOMED 398254007).

Look up a PSGC geographic code:

```bash
curl -s "https://tx.fhirlab.net/fhir/CodeSystem/\$lookup?system=https://psa.gov.ph/classification/psgc&code=0600400000" \
  -H "Accept: application/fhir+json" | jq .
```

Verify a LOINC observation code:

```bash
curl -s "https://tx.fhirlab.net/fhir/CodeSystem/\$lookup?system=http://loinc.org&code=85354-9" \
  -H "Accept: application/fhir+json" | jq .
```

### Key SNOMED CT Codes in This Referral

<div class="ph-table" markdown="1">

| Code | Display | Where Used |
|------|---------|------------|
| `398254007` | Pre-eclampsia | Working impression diagnosis |
| `25064002` | Headache | Chief complaint |
| `75367002` | Blood pressure | BP observation co-coding |
| `78564009` | Pulse rate | Heart rate observation |
| `86290005` | Respiratory rate | Respiratory rate observation |
| `103228002` | Hemoglobin saturation with oxygen | SpO₂ observation |
| `386725007` | Body temperature | Temperature observation |
| `27113001` | Body weight | Weight observation |
| `416608005` | Drug therapy | Pre-referral treatment procedure |
| `73770003` | Hospital-based outpatient emergency care center | Referral category |
| `71388002` | Procedure | Reason for referral |
| `3457005` | Patient referral | Task code |
| `158965000` | Medical practitioner | PractitionerRole code |

</div>

### Key LOINC Codes in This Referral

<div class="ph-table" markdown="1">

| Code | Display | Where Used |
|------|---------|------------|
| `85354-9` | Blood pressure panel with all children optional | BP observation magic code |
| `8480-6` | Systolic blood pressure | BP component systolic |
| `8462-4` | Diastolic blood pressure | BP component diastolic |
| `8867-4` | Heart rate | HR observation |
| `9279-1` | Respiratory rate | RR observation |
| `2708-6` | Oxygen saturation in Arterial blood | SpO₂ observation |
| `8310-5` | Body temperature | Temperature observation |
| `29463-7` | Body weight | Weight observation |
| `24356-8` | Urinalysis complete panel - Urine | Diagnostic report |

</div>

### Key PSGC Geographic Codes in This Referral

<div class="ph-table" markdown="1">

| Code | Display | Level |
|------|---------|-------|
| `0600000000` | Region VI (Western Visayas) | Region |
| `0600400000` | Aklan | Province |
| `0600407000` | Kalibo | City/Municipality |
| `0600407013` | Poblacion | Barangay |

</div>

---

## The Transaction Bundle

The referral initiation is sent as a **single FHIR transaction Bundle** — all entries succeed or fail atomically.

### Conditional Update (PUT)

Master data entries use FHIR's [conditional update](https://www.hl7.org/fhir/http.html#cond-update) pattern: `PUT [ResourceType]?identifier=[system]|[value]`. When the server receives the bundle:

1. It searches for an existing resource matching the identifier
2. If found — the resource is **updated** in-place
3. If not found — a **new** resource is created

This makes repeated submissions **idempotent** — posting the same referral twice won't create duplicate Patient, Practitioner, Organization, or PractitionerRole records.

### The 7 Conditional PUT Entries

The full bundle contains 20 entries. The 7 master data entries below use conditional PUT. The remaining 13 clinical entries (ServiceRequest, Encounter, Conditions, Observations, Procedure, DiagnosticReport, Task, Provenance) use plain POST.

#### Request

```
POST https://cdr.fhirlab.net/fhir
Content-Type: application/fhir+json
Accept: application/fhir+json
```

#### Request Body (Master Data Entries Only)

```jsonc
// Target server: https://cdr.fhirlab.net/fhir
// Bundle type: transaction (atomic — all-or-nothing)
// Entry strategy: PUT + identifier → upsert master data
//                 POST          → always-create clinical data
{
  "resourceType": "Bundle",
  "type": "transaction",
  "entry": [
    // ── Master Data: Conditional PUT entries (upsert via identifier) ──
    {
      "fullUrl": "urn:uuid:d7e33c3b-e90b-464e-a5eb-a92f60c71542",
      "resource": {
        "resourceType": "Patient",
        "meta": {"profile": ["https://fhir.doh.gov.ph/pheref/StructureDefinition/ERefPatient"]},
        "name": [{"use": "official", "family": "Reyes", "given": ["Ana", "Luisa"]}],
        "gender": "female",
        "birthDate": "1988-03-12",
        "identifier": [
          {"system": "http://philhealth.gov.ph/fhir/Identifier/philhealth-id", "value": "78-658064775-3"},
          {"system": "http://philsys.gov.ph/fhir/Identifier/philsys-id", "value": "7731-0812-4491-0326"}
        ],
        "address": [{
          "use": "home", "line": ["Area 4, Barangay Mabuhay"], "postalCode": "5600", "country": "PH",
          "extension": [
            {"url": "https://fhir.doh.gov.ph/phcore/StructureDefinition/region", "valueCoding": {"system": "https://psa.gov.ph/classification/psgc", "code": "0600000000"}},
            {"url": "https://fhir.doh.gov.ph/phcore/StructureDefinition/province", "valueCoding": {"system": "https://psa.gov.ph/classification/psgc", "code": "0600400000"}},
            {"url": "https://fhir.doh.gov.ph/phcore/StructureDefinition/city-municipality", "valueCoding": {"system": "https://psa.gov.ph/classification/psgc", "code": "0600407000"}},
            {"url": "https://fhir.doh.gov.ph/phcore/StructureDefinition/barangay", "valueCoding": {"system": "https://psa.gov.ph/classification/psgc", "code": "0600407013"}}
          ]
        }],
        "contact": [{
          "relationship": [{"coding": [{"system": "http://terminology.hl7.org/CodeSystem/v3-RoleCode", "code": "HUSB"}]}],
          "name": {"use": "official", "family": "Reyes", "given": ["Roberto"]}
        }]
      },
      // PUT by PhilSys ID → upsert Patient
      "request": {"method": "PUT", "url": "Patient?identifier=http://philsys.gov.ph/fhir/Identifier/philsys-id|7731-0812-4491-0326"}
    },
    {
      "fullUrl": "urn:uuid:309021d0-7abe-4b54-b2e9-23a056851d0e",
      "resource": {
        "resourceType": "Practitioner",
        "meta": {"profile": ["https://fhir.doh.gov.ph/phcore/StructureDefinition/ph-core-practitioner"]},
        "identifier": [{"system": "https://prc.gov.ph/", "value": "5466863"}],
        "name": [{"use": "official", "family": "Villanueva", "given": ["Maria"], "prefix": ["Dr."]}]
      },
      // PUT by PRC license number → upsert Practitioner (referring: Dr. Villanueva)
      "request": {"method": "PUT", "url": "Practitioner?identifier=https://prc.gov.ph/|5466863"}
    },
    {
      "fullUrl": "urn:uuid:4f8b2c1d-9a3e-4b7c-8d1f-2e6a5b3c0d9e",
      "resource": {
        "resourceType": "Practitioner",
        "meta": {"profile": ["https://fhir.doh.gov.ph/phcore/StructureDefinition/ph-core-practitioner"]},
        "identifier": [{"system": "https://prc.gov.ph/", "value": "7890123"}],
        "name": [{"use": "official", "family": "Lim", "given": ["Carlos"], "prefix": ["Dr."]}]
      },
      // PUT by PRC license number → upsert Practitioner (receiving: Dr. Carlos Lim)
      "request": {"method": "PUT", "url": "Practitioner?identifier=https://prc.gov.ph/|7890123"}
    },
    {
      "fullUrl": "urn:uuid:a038f451-6557-4b01-b05c-aa4ff967545b",
      "resource": {
        "resourceType": "Organization",
        "meta": {"profile": ["https://fhir.doh.gov.ph/phcore/StructureDefinition/ph-core-organization"]},
        "name": "Kalibo Health Center",
        "identifier": [
          {"system": "https://fhir.doh.gov.ph/phcore/Identifier/doh-nhfr-code", "value": "3056"},
          {"system": "https://fhir.doh.gov.ph/phcore/Identifier/hcpn-code", "value": "Aklan HCPN"}
        ],
        "telecom": [{"system": "phone", "value": "(043) 756-2233", "use": "work"}],
        "address": [{
          "use": "work", "line": ["Mabini Street"], "postalCode": "5600", "country": "PH",
          "extension": [
            {"url": "https://fhir.doh.gov.ph/phcore/StructureDefinition/region", "valueCoding": {"system": "https://psa.gov.ph/classification/psgc", "code": "0600000000"}},
            {"url": "https://fhir.doh.gov.ph/phcore/StructureDefinition/province", "valueCoding": {"system": "https://psa.gov.ph/classification/psgc", "code": "0600400000"}},
            {"url": "https://fhir.doh.gov.ph/phcore/StructureDefinition/city-municipality", "valueCoding": {"system": "https://psa.gov.ph/classification/psgc", "code": "0600407000"}},
            {"url": "https://fhir.doh.gov.ph/phcore/StructureDefinition/barangay", "valueCoding": {"system": "https://psa.gov.ph/classification/psgc", "code": "0600407013"}}
          ]
        }]
      },
      // PUT by NHFR code → upsert Organization (referring: KHC)
      "request": {"method": "PUT", "url": "Organization?identifier=https://fhir.doh.gov.ph/phcore/Identifier/doh-nhfr-code|3056"}
    },
    {
      "fullUrl": "urn:uuid:06924c91-7363-40ab-932b-6f64d0a102b9",
      "resource": {
        "resourceType": "PractitionerRole",
        "meta": {"profile": ["https://fhir.doh.gov.ph/pheref/StructureDefinition/ERefPractitionerRole"]},
        "practitioner": {"reference": "urn:uuid:309021d0-7abe-4b54-b2e9-23a056851d0e"},
        "organization": {"reference": "urn:uuid:a038f451-6557-4b01-b05c-aa4ff967545b"},
        "code": [{"coding": [{"system": "http://snomed.info/sct", "code": "158965000", "display": "Medical practitioner"}]}]
      },
      // PUT by PRC ID → upsert PractitionerRole (referring: KHC, inherits Practitioner's PRC)
      "request": {"method": "PUT", "url": "PractitionerRole?identifier=https://prc.gov.ph/|5466863"}
    },
    {
      "fullUrl": "urn:uuid:8c97c63e-4dbf-45d5-894e-f671e385a126",
      "resource": {
        "resourceType": "Organization",
        "meta": {"profile": ["https://fhir.doh.gov.ph/phcore/StructureDefinition/ph-core-organization"]},
        "name": "Dr. Rafael S. Tumbokon Memorial Hospital",
        "identifier": [
          {"system": "https://fhir.doh.gov.ph/phcore/Identifier/doh-nhfr-code", "value": "513"},
          {"system": "https://fhir.doh.gov.ph/phcore/Identifier/hcpn-code", "value": "Aklan HCPN"}
        ],
        "telecom": [{"system": "phone", "value": "(043) 756-3124", "use": "work"}]
      },
      // PUT by NHFR code → upsert Organization (receiving: DRSTMH)
      "request": {"method": "PUT", "url": "Organization?identifier=https://fhir.doh.gov.ph/phcore/Identifier/doh-nhfr-code|513"}
    },
    {
      "fullUrl": "urn:uuid:6ce0a17b-7fb3-4075-a524-3afd390731de",
      "resource": {
        "resourceType": "PractitionerRole",
        "meta": {"profile": ["https://fhir.doh.gov.ph/pheref/StructureDefinition/ERefPractitionerRole"]},
        "practitioner": {"reference": "urn:uuid:4f8b2c1d-9a3e-4b7c-8d1f-2e6a5b3c0d9e"},
        "organization": {"reference": "urn:uuid:8c97c63e-4dbf-45d5-894e-f671e385a126"},
        "code": [{"coding": [{"system": "http://snomed.info/sct", "code": "158965000", "display": "Medical practitioner"}]}]
      },
      // PUT by PRC ID → upsert PractitionerRole (receiving: DRSTMH, inherits Dr. Carlos Lim's PRC)
      "request": {"method": "PUT", "url": "PractitionerRole?identifier=https://prc.gov.ph/|7890123"}
    }
    // ── Clinical / Business Data: POST entries (new resource per referral) ──
    // Entries 8–20 (ServiceRequest, Encounter, Conditions, Observations,
    // Procedure, DiagnosticReport, Task, Provenance) all use POST.
    // See the full Bundle JSON download for all 20 entries.
  ]
}
```

> The remaining 14 clinical entries (ServiceRequest, Encounter, Conditions, Observations, Procedure, DiagnosticReport, Task, Provenance) all use `POST` — each referral generates new clinical records. Full bundle available below.

### Full Bundle Downloads

- **JSON**: [`Bundle-ExampleERefSubmissionBundle.json`](Bundle-ExampleERefSubmissionBundle.json) — Download and POST directly to any FHIR server
- **Rendered**: [`Bundle-ExampleERefSubmissionBundle.html`](Bundle-ExampleERefSubmissionBundle.html) — IG-rendered view with narrative
- **FSH Source**: [`input/fsh/examples/ERefInitiatingFacilityBundle.fsh`](https://github.com/ph-ereferral-organization/ph-ereferral/blob/main/input/fsh/examples/ERefInitiatingFacilityBundle.fsh)

### Bundle Entry Ordering Note

Entries are ordered so that referenced resources appear first. Master data (PUT entries) come before clinical data (POST entries). The ServiceRequest precedes the Task and Provenance that reference it.

---

## Reading Back Resources

After posting the Bundle, retrieve individual resources by their server-assigned IDs.

### Read a Patient

```
GET https://cdr.fhirlab.net/fhir/Patient/{patient-id}
Accept: application/fhir+json
```

```bash
curl -s "https://cdr.fhirlab.net/fhir/Patient/{patient-id}" \
  -H "Accept: application/fhir+json" | jq .
```

### Read the ServiceRequest

```
GET https://cdr.fhirlab.net/fhir/ServiceRequest/{sr-id}
Accept: application/fhir+json
```

```bash
curl -s "https://cdr.fhirlab.net/fhir/ServiceRequest/{sr-id}" \
  -H "Accept: application/fhir+json" | jq .
```

### Read All Observations for the Encounter

```
GET https://cdr.fhirlab.net/fhir/Observation?encounter=Encounter/{enc-id}
Accept: application/fhir+json
```

```bash
curl -s "https://cdr.fhirlab.net/fhir/Observation?encounter=Encounter/{enc-id}" \
  -H "Accept: application/fhir+json" | jq .
```

### Read the Task

```
GET https://cdr.fhirlab.net/fhir/Task/{task-id}
Accept: application/fhir+json
```

```bash
curl -s "https://cdr.fhirlab.net/fhir/Task/{task-id}" \
  -H "Accept: application/fhir+json" | jq .
```

---

## Searching for Referrals

### Search for Referrals by Patient

```
GET https://cdr.fhirlab.net/fhir/ServiceRequest?subject=Patient/{patient-id}
Accept: application/fhir+json
```

```bash
curl -s "https://cdr.fhirlab.net/fhir/ServiceRequest?subject=Patient/{patient-id}" \
  -H "Accept: application/fhir+json" | jq .
```

### Search for Referrals by Status

```
GET https://cdr.fhirlab.net/fhir/ServiceRequest?status=active&intent=order
Accept: application/fhir+json
```

```bash
curl -s "https://cdr.fhirlab.net/fhir/ServiceRequest?status=active&intent=order" \
  -H "Accept: application/fhir+json" | jq .
```

### Search for Tasks by Status

```
GET https://cdr.fhirlab.net/fhir/Task?status=requested
Accept: application/fhir+json
```

```bash
curl -s "https://cdr.fhirlab.net/fhir/Task?status=requested" \
  -H "Accept: application/fhir+json" | jq .
```

### Search for Tasks by Focus (Referral)

```
GET https://cdr.fhirlab.net/fhir/Task?focus=ServiceRequest/{sr-id}
Accept: application/fhir+json
```

```bash
curl -s "https://cdr.fhirlab.net/fhir/Task?focus=ServiceRequest/{sr-id}" \
  -H "Accept: application/fhir+json" | jq .
```

### Search for Conditions by Patient

```
GET https://cdr.fhirlab.net/fhir/Condition?subject=Patient/{patient-id}
Accept: application/fhir+json
```

```bash
curl -s "https://cdr.fhirlab.net/fhir/Condition?subject=Patient/{patient-id}" \
  -H "Accept: application/fhir+json" | jq .
```

### Common Search Parameters

<div class="ph-table" markdown="1">

| Resource | Search Parameter | Example |
|----------|-----------------|---------|
| ServiceRequest | `subject` | `?subject=Patient/123` |
| ServiceRequest | `status` | `?status=active` |
| ServiceRequest | `authored` | `?authored=ge2026-06-18` |
| Task | `status` | `?status=requested` |
| Task | `focus` | `?focus=ServiceRequest/456` |
| Task | `owner` | `?owner=PractitionerRole/789` |
| Condition | `subject` | `?subject=Patient/123` |
| Observation | `subject` | `?subject=Patient/123` |
| Observation | `encounter` | `?encounter=Encounter/789` |
| Observation | `code` | `?code=http://loinc.org\|85354-9` |

</div>

---

## Tracing the Workflow — Task State Progression

The referral workflow is tracked through the **Task** resource's `status` field. This section shows how to update the Task as the referral moves through its lifecycle.

### Workflow States

The referral follows this state progression:

1. **`requested`** — Referral sent (initiation Bundle)
2. **`received`** — Receiving facility acknowledges
3. **`accepted`** — Receiving facility accepts referral
4. **`completed`** — Referral encounter complete
5. **`rejected`** — Cannot accept referral

### Step 1: Referral Created (`requested`)

This is the state after the transaction Bundle POST. The Task is created with `status = "requested"`.

```
GET https://cdr.fhirlab.net/fhir/Task/{task-id}
Accept: application/fhir+json
```

```bash
# Read the Task to verify initial state
curl -s "https://cdr.fhirlab.net/fhir/Task/{task-id}" \
  -H "Accept: application/fhir+json" | jq '.status'
# Expected: "requested"
```

### Step 2: Receiving Facility Acknowledges (`received`)

The receiving facility updates the Task to indicate receipt:

```
PUT https://cdr.fhirlab.net/fhir/Task/{task-id}
Content-Type: application/fhir+json
Accept: application/fhir+json
```

```jsonc
// Task update body — fields that change per state transition:
//   status:       "requested" → "received" → "accepted" → "completed"
//   lastModified: timestamp of state change
//   note:         free-text reason for transition
// All other fields must be kept from the original Task resource.
{
  "resourceType": "Task",
  "id": "{task-id}",
  "meta": {"profile": ["https://fhir.doh.gov.ph/pheref/StructureDefinition/ereferral-task"]},
  "status": "received",                                              // ⬅ the target state
  "intent": "order",
  "code": {"coding": [{"system": "http://snomed.info/sct", "code": "3457005", "display": "Patient referral"}]},
  "focus": {"reference": "ServiceRequest/{sr-id}"},
  "for": {"reference": "Patient/{patient-id}"},
  "requester": {"reference": "PractitionerRole/{pr-khc-id}"},
  "owner": {"reference": "PractitionerRole/{pr-rstmh-id}"},
  "authoredOn": "2026-06-18T08:30:00+08:00",
  "lastModified": "2026-06-18T09:00:00+08:00",                     // ⬅ set to now
  "note": [{"text": "Referral received by DRSTMH. Pending triage review."}]
}
```

```bash
curl -s -X PUT "https://cdr.fhirlab.net/fhir/Task/{task-id}" \
  -H "Content-Type: application/fhir+json" \
  -H "Accept: application/fhir+json" \
  -d '{
    "resourceType": "Task",
    "id": "{task-id}",
    "meta": {"profile": ["https://fhir.doh.gov.ph/pheref/StructureDefinition/ereferral-task"]},
    "status": "received",
    "intent": "order",
    "code": {"coding": [{"system": "http://snomed.info/sct", "code": "3457005", "display": "Patient referral"}]},
    "focus": {"reference": "ServiceRequest/{sr-id}"},
    "for": {"reference": "Patient/{patient-id}"},
    "requester": {"reference": "PractitionerRole/{pr-khc-id}"},
    "owner": {"reference": "PractitionerRole/{pr-rstmh-id}"},
    "authoredOn": "2026-06-18T08:30:00+08:00",
    "lastModified": "2026-06-18T09:00:00+08:00",
    "note": [{"text": "Referral received by DRSTMH. Pending triage review."}]
  }'
```

### Step 3: Receiving Facility Accepts (`accepted`)

After triage review, the receiving facility accepts the referral:

```
PUT https://cdr.fhirlab.net/fhir/Task/{task-id}
Content-Type: application/fhir+json
Accept: application/fhir+json
```

```jsonc
// Same body structure as Step 2 — only status and note change:
//   status:       "accepted"
//   lastModified: updated timestamp
//   note:         acceptance rationale
{
  // ... all immutable fields from Step 2, then:
  "status": "accepted",
  "lastModified": "2026-06-18T09:45:00+08:00",
  "note": [{"text": "Referral accepted. Patient will be admitted for severe pre-eclampsia management."}]
}
```

```bash
curl -s -X PUT "https://cdr.fhirlab.net/fhir/Task/{task-id}" \
  -H "Content-Type: application/fhir+json" \
  -H "Accept: application/fhir+json" \
  -d '{
    "resourceType": "Task",
    "id": "{task-id}",
    "meta": {"profile": ["https://fhir.doh.gov.ph/pheref/StructureDefinition/ereferral-task"]},
    "status": "accepted",
    "intent": "order",
    "code": {"coding": [{"system": "http://snomed.info/sct", "code": "3457005", "display": "Patient referral"}]},
    "focus": {"reference": "ServiceRequest/{sr-id}"},
    "for": {"reference": "Patient/{patient-id}"},
    "requester": {"reference": "PractitionerRole/{pr-khc-id}"},
    "owner": {"reference": "PractitionerRole/{pr-rstmh-id}"},
    "authoredOn": "2026-06-18T08:30:00+08:00",
    "lastModified": "2026-06-18T09:45:00+08:00",
    "note": [{"text": "Referral accepted. Patient will be admitted for severe pre-eclampsia management."}]
  }'
```

### Step 4: Referral Completed (`completed`)

After the referral encounter is complete:

```
PUT https://cdr.fhirlab.net/fhir/Task/{task-id}
Content-Type: application/fhir+json
Accept: application/fhir+json
```

```jsonc
// Same body structure as Step 2 — only status and note change:
//   status:       "completed"
//   lastModified: updated timestamp
//   note:         completion summary
{
  // ... all immutable fields from Step 2, then:
  "status": "completed",
  "lastModified": "2026-06-18T14:00:00+08:00",
  "note": [{"text": "Referral completed. Patient admitted and stabilized at DRSTMH."}]
}
```

```bash
curl -s -X PUT "https://cdr.fhirlab.net/fhir/Task/{task-id}" \
  -H "Content-Type: application/fhir+json" \
  -H "Accept: application/fhir+json" \
  -d '{
    "resourceType": "Task",
    "id": "{task-id}",
    "meta": {"profile": ["https://fhir.doh.gov.ph/pheref/StructureDefinition/ereferral-task"]},
    "status": "completed",
    "intent": "order",
    "code": {"coding": [{"system": "http://snomed.info/sct", "code": "3457005", "display": "Patient referral"}]},
    "focus": {"reference": "ServiceRequest/{sr-id}"},
    "for": {"reference": "Patient/{patient-id}"},
    "requester": {"reference": "PractitionerRole/{pr-khc-id}"},
    "owner": {"reference": "PractitionerRole/{pr-rstmh-id}"},
    "authoredOn": "2026-06-18T08:30:00+08:00",
    "lastModified": "2026-06-18T14:00:00+08:00",
    "note": [{"text": "Referral completed. Patient admitted and stabilized at DRSTMH."}]
  }'
```

> **Important:** When using PUT to update the Task, you must send the **complete** resource, including all existing fields. PUT replaces the entire resource. If you omit a required field, the server may reject the update. Read the current Task first with GET, modify the fields you want to change, then PUT the complete resource back.

### Using PATCH for Status Updates

If your FHIR server supports PATCH, you can update only the `status` field:

```
PATCH https://cdr.fhirlab.net/fhir/Task/{task-id}
Content-Type: application/json-patch+json
Accept: application/fhir+json
```

```jsonc
// JSON Patch body: only the fields that change
// op:   "replace" — update an existing field's value
// path: JSON Pointer to the field being changed
[
  {"op": "replace", "path": "/status", "value": "accepted"},
  {"op": "replace", "path": "/lastModified", "value": "2026-06-18T09:45:00+08:00"}
]
```

```bash
curl -s -X PATCH "https://cdr.fhirlab.net/fhir/Task/{task-id}" \
  -H "Content-Type: application/json-patch+json" \
  -H "Accept: application/fhir+json" \
  -d '[
    {"op": "replace", "path": "/status", "value": "accepted"},
    {"op": "replace", "path": "/lastModified", "value": "2026-06-18T09:45:00+08:00"}
  ]'
```

---

## Complete cURL Commands

This section provides the full sequence of commands ready to copy-paste for a connectathon test run. Replace `{id}` placeholders with the actual server-assigned IDs from previous responses.

### 1. Verify Server is Available

```
GET https://cdr.fhirlab.net/fhir/metadata
Accept: application/fhir+json
```

```bash
curl -s "https://cdr.fhirlab.net/fhir/metadata" \
  -H "Accept: application/fhir+json" | jq '.software.name'
```

### 2. Post the Referral Initiation Bundle

```
POST https://cdr.fhirlab.net/fhir
Content-Type: application/fhir+json
Accept: application/fhir+json
```

```jsonc
// Transaction Bundle — 20 entries, submit as a single file.
  // Master data (entries 1–7): PUT  + identifier → upsert
// Clinical data   (entries 7–20): POST             → new resource per referral
// Intra-bundle references use urn:uuid: matching each entry's fullUrl.
// See "The Transaction Bundle" section above for the complete annotated JSON.
{
  "resourceType": "Bundle",
  "type": "transaction",
  "entry": [
    // entries 1–7: Patient, 2× Practitioner, 2× Organization, 2× PractitionerRole (PUT)
    // entries 8–20: ServiceRequest, Encounter, 2× Condition, 6× Observation,
    //              Procedure, DiagnosticReport, Task, Provenance (POST)
  ]
}
```

```bash
curl -s -X POST "https://cdr.fhirlab.net/fhir" \
  -H "Content-Type: application/fhir+json" \
  -H "Accept: application/fhir+json" \
  -d @ana-reyes-bundle.json | jq '.entry[].response.location'
```

Save the full bundle JSON from [Bundle-ExampleERefSubmissionBundle.json](Bundle-ExampleERefSubmissionBundle.json) as `ana-reyes-bundle.json`, then run the command above.

### 3. Read Back Key Resources

```bash
# Read Patient
curl -s "https://cdr.fhirlab.net/fhir/Patient/{patient-id}" \
  -H "Accept: application/fhir+json" | jq '{id, name: .name[0], gender, birthDate}'

# Read ServiceRequest
curl -s "https://cdr.fhirlab.net/fhir/ServiceRequest/{sr-id}" \
  -H "Accept: application/fhir+json" | jq '{id, status, intent, reasonCode}'

# Read Task
curl -s "https://cdr.fhirlab.net/fhir/Task/{task-id}" \
  -H "Accept: application/fhir+json" | jq '{id, status, code}'
```

### 4. Search for All Referrals for This Patient

```
GET https://cdr.fhirlab.net/fhir/ServiceRequest?subject=Patient/{patient-id}
Accept: application/fhir+json
```

```bash
curl -s "https://cdr.fhirlab.net/fhir/ServiceRequest?subject=Patient/{patient-id}" \
  -H "Accept: application/fhir+json" | jq '.total'
```

### 5. Trace the Workflow

```
GET https://cdr.fhirlab.net/fhir/Task/{task-id}
Accept: application/fhir+json

PATCH https://cdr.fhirlab.net/fhir/Task/{task-id}
Content-Type: application/json-patch+json
Accept: application/fhir+json
```

```jsonc
// JSON Patch body per state — change "status" to advance the workflow:
//   "requested" → "received" → "accepted" → "completed"
[
  {"op": "replace", "path": "/status", "value": "received"},        // ⬅ the target state
  {"op": "replace", "path": "/lastModified", "value": "2026-06-18T09:00:00+08:00"}
]
```

```bash
# Step 1: Check initial Task status
curl -s "https://cdr.fhirlab.net/fhir/Task/{task-id}" \
  -H "Accept: application/fhir+json" | jq '.status'
# Expected: "requested"

# Step 2: Update Task to received
curl -s -X PATCH "https://cdr.fhirlab.net/fhir/Task/{task-id}" \
  -H "Content-Type: application/json-patch+json" \
  -H "Accept: application/fhir+json" \
  -d '[{"op": "replace", "path": "/status", "value": "received"}]'

# Step 3: Update Task to accepted
curl -s -X PATCH "https://cdr.fhirlab.net/fhir/Task/{task-id}" \
  -H "Content-Type: application/json-patch+json" \
  -H "Accept: application/fhir+json" \
  -d '[{"op": "replace", "path": "/status", "value": "accepted"}]'

# Step 4: Update Task to completed
curl -s -X PATCH "https://cdr.fhirlab.net/fhir/Task/{task-id}" \
  -H "Content-Type: application/json-patch+json" \
  -H "Accept: application/fhir+json" \
  -d '[{"op": "replace", "path": "/status", "value": "completed"}]'
```

### 6. Verify Final State

```
GET https://cdr.fhirlab.net/fhir/Task/{task-id}
Accept: application/fhir+json
```

```bash
# Verify Task is completed
curl -s "https://cdr.fhirlab.net/fhir/Task/{task-id}" \
  -H "Accept: application/fhir+json" | jq '{id, status, lastModified}'
# Expected: status = "completed"
```

---

## Key Takeaways

### Bundle Structure

- The eReferral initiation Bundle is a **`transaction`** type Bundle — all entries succeed or fail atomically
- **Master data** (Patient, Practitioner ×2, Organization ×2, PractitionerRole ×2) uses conditional **PUT** — resubmitting the same identifiers updates existing records. PractitionerRole inherits identifiers from its linked Practitioner (PRC).
- **Clinical data** (ServiceRequest, Encounter, Condition, Observation, Procedure, DiagnosticReport, Task, Provenance) uses **POST** — each referral generates new clinical records
- Intra-Bundle references use **`urn:uuid:`** identifiers matching entry `fullUrl` values

### Codes and Terminology

- **SNOMED CT** codes are used for clinical findings, procedures, and referral categories — look them up at `https://tx.fhirlab.net/fhir`
- **LOINC** codes are used for observations and lab panels — each observation profile requires a specific LOINC "magic code"
- **PSGC** codes are used for geographic addressing (region → province → city → barangay) via PH Core address extensions
- Vital sign observations are **co-coded** with both LOINC (primary) and SNOMED (secondary) for SNOMED International Edition compatibility

### PSGC Address Pattern

- Base FHIR address fields (`city`, `state`, `district`) are **replaced** by four named extension slices on the `Address` type
- Always use `extension[region]`, `extension[province]`, `extension[city-municipality]`, `extension[barangay]` — not the flat fields
- Only `address.line`, `address.postalCode`, `address.country`, `address.use`, `address.type`, and `address.text` are used directly

### Workflow Tracing

- The **Task** resource tracks referral lifecycle: `requested` → `received` → `accepted` → `completed`
- Each state transition updates `Task.status` and `Task.lastModified`
- Use **PUT** (full resource replacement) or **PATCH** (partial update) to advance the workflow state
- The **Provenance** resource captures signature attestation and audit trail

### Server-Specific Notes

- Use `https://cdr.fhirlab.net/fhir` for REST API operations (CRUD, search, Bundles)
- Use `https://tx.fhirlab.net/fhir` for terminology operations (`$lookup`, `$validate-code`)
- PH Core CodeSystems (`PHCW`, `PSOC`) use a `phcore` namespace (`https://fhir.doh.gov.ph/phcore/CodeSystem/...`) served from the ontoserver at `tx.fhirlab.net`

---

## Links to Rendered Artifacts

The generated artifact pages in this IG provide the authoritative, rendered view of each profile and example instance referenced in this tutorial.

### Profiles Used

<div class="ph-table" markdown="1">

| Profile | Artifact Page |
|---------|---------------|
| ERefPatient | [StructureDefinition/ERefPatient](StructureDefinition-ereferral-patient.html) |
| ERefEncounter | [StructureDefinition/ereferral-encounter](StructureDefinition-ereferral-encounter.html) |
| ERefCondition | [StructureDefinition/ereferral-condition](StructureDefinition-ereferral-condition.html) |
| ERefObservation | [StructureDefinition/ereferral-observation](StructureDefinition-ereferral-observation.html) |
| ERefProcedure | [StructureDefinition/ereferral-procedure](StructureDefinition-ereferral-procedure.html) |
| ERefServiceRequest | [StructureDefinition/ereferral-service-request](StructureDefinition-ereferral-service-request.html) |
| ERefTask | [StructureDefinition/ereferral-task](StructureDefinition-ereferral-task.html) |
| ERefProvenance | [StructureDefinition/ereferral-provenance](StructureDefinition-ereferral-provenance.html) |
| ERefPractitionerRole | [StructureDefinition/ERefPractitionerRole](StructureDefinition-ereferral-practitioner-role.html) |

</div>

### Example Instances Used

<div class="ph-table" markdown="1">

| Example Instance | Artifact Page |
|------------------|---------------|
| Submission Bundle (full) | [Bundle/ExampleERefSubmissionBundle](Bundle-ExampleERefSubmissionBundle.html) |
| Patient — Ana Reyes | [Patient/ExampleERefPatient](Patient-ExampleERefPatient.html) |
| ServiceRequest | [ServiceRequest/ExampleERefServiceRequest](ServiceRequest-ExampleERefServiceRequest.html) |
| Encounter | [Encounter/ExampleERefSubmissionEncounter](Encounter-ExampleERefSubmissionEncounter.html) |
| Condition — Chief Complaint | [Condition/ExampleERefConditionChiefComplaint](Condition-ExampleERefConditionChiefComplaint.html) |
| Condition — Pre-eclampsia | [Condition/ExampleERefCondition](Condition-ExampleERefCondition.html) |
| Observation — Blood Pressure | [Observation/ExampleERefObservationBP](Observation-ExampleERefObservationBP.html) |
| Observation — Heart Rate | [Observation/ExampleERefObservationHR](Observation-ExampleERefObservationHR.html) |
| Observation — Respiratory Rate | [Observation/ExampleERefObservationRR](Observation-ExampleERefObservationRR.html) |
| Observation — Oxygen Saturation | [Observation/ExampleERefObservationSpO2](Observation-ExampleERefObservationSpO2.html) |
| Observation — Temperature | [Observation/ExampleERefObservationTemp](Observation-ExampleERefObservationTemp.html) |
| Observation — Weight | [Observation/ExampleERefObservationWeight](Observation-ExampleERefObservationWeight.html) |
| Procedure | [Procedure/ExampleERefProcedureTreatment](Procedure-ExampleERefProcedureTreatment.html) |
| DiagnosticReport | [DiagnosticReport/ExampleERefDiagnosticReport](DiagnosticReport-ExampleERefDiagnosticReport.html) |
| Task — Requested | [Task/ExampleERefTaskRequested](Task-ExampleERefTaskRequested.html) |
| Provenance | [Provenance/ExampleERefProvenanceSubmission](Provenance-ExampleERefProvenanceSubmission.html) |
| Practitioner — Dr. Villanueva | [Practitioner/ExampleERefPractitionerSubmission](Practitioner-ExampleERefPractitionerSubmission.html) |
| Practitioner — Dr. Carlos Lim | [Practitioner/ExampleERefPractitionerReceiving](Practitioner-ExampleERefPractitionerReceiving.html) |
| Organization — KHC | [Organization/ExampleERefOrganizationKaliboHC](Organization-ExampleERefOrganizationKaliboHC.html) |
| Organization — DRSTMH | [Organization/ExampleERefOrganizationDRSTMH](Organization-ExampleERefOrganizationDRSTMH.html) |
| PractitionerRole — KHC | [PractitionerRole/ExampleERefPractitionerRoleSubmission](PractitionerRole-ExampleERefPractitionerRoleSubmission.html) |
| PractitionerRole — DRSTMH | [PractitionerRole/ExampleERefPractitionerRoleReceiving](PractitionerRole-ExampleERefPractitionerRoleReceiving.html) |

</div>

### Source FSH

The FSH source for all examples in this tutorial is in [`input/fsh/examples/ERefInitiatingFacilityBundle.fsh`](https://github.com/ph-ereferral-organization/ph-ereferral/blob/main/input/fsh/examples/ERefInitiatingFacilityBundle.fsh). This is the single source file containing all 20 instance definitions compiled by SUSHI into the FHIR JSON rendered by the IG Publisher.
