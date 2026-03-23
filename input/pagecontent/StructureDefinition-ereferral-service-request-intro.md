### EReferral ServiceRequest Profile

The **EReferral ServiceRequest** profile defines the core structure for electronic referral requests in the Philippine healthcare context. It is based on the FHIR [ServiceRequest](http://hl7.org/fhir/R4/servicerequest.html) resource and establishes the minimum expectations for systems implementing patient referrals between healthcare facilities.

---

#### Scope and Purpose

This profile supports the electronic exchange of referral information between:

- **Rural Health Units (RHUs)** and **tertiary hospitals**
- **Primary care facilities** and **specialist centers**
- **Any healthcare facilities** participating in the Philippine eReferral system

The profile maps to the **Technical Working Group on Digital Health (TDG) eReferral Data Elements** (rows REF-1 through REF-21), ensuring alignment with national health data standards.

---

#### Key Concepts

##### Referral Requester (Initiating Facility)

The `requester` element uses a **PractitionerRole** reference to capture:

| TDG Row | Data Element | FHIR Path |
|---------|--------------|-----------|
| REF-1 | Name of Referring Practitioner | `requester` (via PractitionerRole -> Practitioner) |
| REF-2 | Practitioner Role | `requester.code` (PractitionerRole.code) |
| REF-5 | Initiating Facility Name | `requester` (via PractitionerRole's Organization) |
| REF-6 | Initiating Facility NHFR Code | `requester` (via PractitionerRole's Organization.identifier) |
| REF-7 | Initiating Facility Address | `requester` (via PractitionerRole's Organization.address) |
| REF-8 | Initiating Facility Contact Number | `requester` (via PractitionerRole's Organization.telecom) |

**Example:**
```fsh
* requester = Reference(PractitionerRole/123)
  // PractitionerRole links to both Practitioner and Organization
```

##### Referral Performer (Receiving Facility)

The `performer` element identifies where the service should be performed:

| TDG Row | Data Element | FHIR Path |
|---------|--------------|-----------|
| REF-9 | Care Navigator | `performer` (via PractitionerRole on receiving side) |
| REF-10 | Receiving Facility Name | `performer` -> PractitionerRole.organization.display |
| REF-11 | Receiving Facility NHFR Code | `performer` -> PractitionerRole.organization.identifier |

**Example:**
```fsh
* performer = Reference(Organization/456)
  // Direct reference to receiving hospital
```

##### Referral Category and Priority

The profile uses value sets to standardize categorization:

| Element | Value Set | Binding | Description |
|---------|-----------|---------|-------------|
| `category` | [EReferralServiceCategory](ValueSet-ereferral-service-category.html) | Extensible | Type of service (imaging, laboratory, surgical, etc.) |
| `priority` | [EReferralPriority](ValueSet-ereferral-priority.html) | Required | Urgency level: routine, urgent, or stat |
| `intent` | Fixed value | N/A | Always `#order` for referrals |

**Example:**
```fsh
* category = $sct#363679005 "Imaging"
* priority = #urgent
* intent = #order  // Fixed value
```

##### Reason for Referral

The profile supports both coded and free-text reasons:

| TDG Row | Data Element | FHIR Path |
|---------|--------------|-----------|
| REF-16 | Reason for Referral (service type) | `code` |
| REF-16 | Reason for Referral (clinical) | `reasonCode`, `reasonReference` |

The `reasonCode` element is bound to the [EReferralReason](ValueSet-ereferral-reason.html) value set (example binding), which includes common SNOMED CT clinical findings such as:

- Dyspnea
- Chest pain
- Suspected lung cancer
- Congestive heart failure
- Atrial fibrillation
- Essential hypertension
- Diabetes mellitus
- Anxiety disorder

**Example:**
```fsh
* code = $sct#183519001 "Referral to cardiology service"
* reasonCode = $sct#29857009 "Chest pain"
  * text = "Chest pain on exertion, suspected unstable angina"
* reasonReference = Reference(Condition/789)
```

##### Supporting Clinical Information

The `supportingInfo` element allows attaching relevant clinical data:

| TDG Row | Data Element | FHIR Path |
|---------|--------------|-----------|
| REF-15 | Clinical Summary | `supportingInfo` |

Allowed resource types:
- **Condition** - Diagnoses and clinical problems
- **Observation** - Vital signs, lab results, imaging findings
- **Procedure** - Previous procedures relevant to referral
- **MedicationAdministration** - Current medications
- **Immunization** - Vaccination history

**Example:**
```fsh
* supportingInfo[0] = Reference(Observation/BP-001)
* supportingInfo[+] = Reference(Observation/ECG-001)
* supportingInfo[+] = Reference(Condition/Diabetes-001)
```

---

#### Must Support Elements

The following elements are marked as **Must Support** and must be implemented by conformant systems:

| Element | Cardinality | Description |
|---------|-------------|-------------|
| `requester` | 1..1 | Referring practitioner (via PractitionerRole) |
| `relevantHistory` | 0..* | Audit trail via Provenance |
| `performer` | 0..* | Receiving facility or practitioner |
| `authoredOn` | 0..1 | When the referral was created |
| `category` | 0..* | Type of referral service |
| `priority` | 0..1 | Urgency level |
| `intent` | 0..1 | Always "order" for referrals |
| `occurrence[x]` | 0..1 | When the service is needed |
| `supportingInfo` | 0..* | Clinical information |
| `code` | 0..1 | Service type being requested |
| `reasonCode` | 0..* | Clinical reason for referral |
| `reasonReference` | 0..* | Conditions/Observations justifying referral |
| `subject` | 0..1 | Patient being referred |
| `status` | 0..1 | Referral status |
| `note` | 0..* | Additional instructions |
| `requisition` | 0..1 | Referral identifier |

---

#### Invariants

The profile includes the following validation rule:

| Invariant | Severity | Expression | Description |
|-----------|----------|------------|-------------|
| `ereferral-requester-has-role` | Warning | `requester.resolve().ofType(PractitionerRole).exists() implies requester.resolve().ofType(PractitionerRole).organization.exists()` | If using PractitionerRole, facility information should be available |

---

#### Referral Lifecycle

The `status` element tracks the referral through its lifecycle:

| Status | Description |
|--------|-------------|
| `draft` | Referral is being prepared |
| `active` | Referral has been sent and is awaiting response |
| `on-hold` | Referral temporarily suspended |
| `revoked` | Referral cancelled by requester |
| `completed` | Service has been rendered |
| `entered-in-error` | Referral created in error |
| `unknown` | Status cannot be determined |

---

#### Usage Scenarios

##### Scenario 1: RHU to Tertiary Hospital Cardiology Referral

A patient at a Rural Health Unit presents with chest pain. The physician creates an urgent referral to a cardiology department.

```fsh
Instance: CardiologyReferral
InstanceOf: ERefServiceRequest
* status = #active
* intent = #order
* priority = #urgent
* category = $sct#409063005 "Counselling"
* code = $sct#183519001 "Referral to cardiology service"
* subject = Reference(Patient/001)
* authoredOn = "2025-03-23T10:00:00+08:00"
* requester = Reference(PractitionerRole/DrSantos)
* performer = Reference(Organization/PhilHeartCenter)
* reasonCode = $sct#29857009 "Chest pain"
* occurrenceDateTime = "2025-03-24T08:00:00+08:00"
```

##### Scenario 2: Diagnostic Imaging Referral

A primary care physician refers a patient for X-ray imaging at a diagnostic center.

```fsh
Instance: XrayReferral
InstanceOf: ERefServiceRequest
* status = #active
* intent = #order
* priority = #routine
* category = $sct#363679005 "Imaging"
* code = $sct#168537006 "Plain X-ray of chest"
* subject = Reference(Patient/002)
* authoredOn = "2025-03-23T14:30:00+08:00"
* requester = Reference(PractitionerRole/DrReyes)
* performer = Reference(Organization/DiagnosticCenter)
* reasonCode = $sct#267036007 "Dyspnea"
* note.text = "Please evaluate for pulmonary infiltrates. Patient has history of pneumonia."
```

---

#### Integration with Other Resources

The EReferral ServiceRequest typically works with:

| Resource | Relationship | Purpose |
|----------|--------------|---------|
| [Patient](http://hl7.org/fhir/R4/patient.html) | `subject` | Patient being referred |
| [PractitionerRole](http://hl7.org/fhir/R4/practitionerrole.html) | `requester` | Referring practitioner with organization context |
| [Organization](http://hl7.org/fhir/R4/organization.html) | `performer` | Receiving facility |
| [Condition](http://hl7.org/fhir/R4/condition.html) | `reasonReference`, `supportingInfo` | Clinical diagnoses |
| [Observation](http://hl7.org/fhir/R4/observation.html) | `supportingInfo` | Vital signs, lab results |
| [Provenance](http://hl7.org/fhir/R4/provenance.html) | `relevantHistory` | Audit trail and signatures |
| [Encounter](http://hl7.org/fhir/R4/encounter.html) | Context | Often linked via Encounter context |

---

#### Philippine-Specific Identifiers

Implementers should use the following identifier systems for Philippine healthcare contexts:

| Identifier Type | System URL | Description |
|-----------------|------------|-------------|
| Philippine Health Insurance (PhilHealth) | `urn:oid:2.16.840.1.113883.2.9.4.3.2` | Patient PhilHealth ID |
| Professional Regulation Commission (PRC) | `urn:oid:2.16.840.1.113883.2.9.4.3.3` | Practitioner license |
| National Health Facility Registry (NHFR) | `urn:oid:2.16.840.1.113883.2.9.4.1.1` | Facility identifier |

---

#### Value Sets

This profile uses the following value sets defined for eReferral:

| Value Set | Description |
|-----------|-------------|
| [EReferralServiceCategory](ValueSet-ereferral-service-category.html) | Categories of referral services |
| [EReferralPriority](ValueSet-ereferral-priority.html) | Priority levels for referrals |
| [EReferralReason](ValueSet-ereferral-reason.html) | Clinical reasons for referral |

---

#### Additional Notes

- **Intent**: The `intent` element is fixed to `#order` because eReferrals are always orders for services to be performed.
- **Requisition ID**: Use the `requisition` element to group related referrals that were authorized simultaneously.
- **Time Called**: Use `occurrenceDateTime` or `occurrencePeriod` to specify when the service is needed.
- **Audit Trail**: The `relevantHistory` element references Provenance resources for tracking changes and signatures.

---

#### See Also

- [EReferral ServiceRequest Profile](StructureDefinition-ereferral-service-request.html)
- [Example EReferral ServiceRequest](ServiceRequest-ExampleERefServiceRequest.html)
- [FHIR ServiceRequest Resource](http://hl7.org/fhir/R4/servicerequest.html)
- [DOH-PHIC JAO No. 2021-0002](https://drive.google.com/file/d/11NC-aCypDLvSx667zXz1NFII3MstveFI/view)