### PH eReferral Server CapabilityStatement

The **PH eReferral CapabilityStatement** defines the conformance requirements for FHIR servers implementing the Philippine eReferral workflow, as validated at the **June 2026 Aklan Connectathon**.

---

#### Scope

This CapabilityStatement describes the minimum server capabilities required to support the eReferral workflow lifecycle:

| Step | Activity | Primary Artifacts |
|------|----------|-------------------|
| 1 | Create or update reference data (conditional PUT) | Patient, Practitioner, Organization, PractitionerRole |
| 2 | Create referral request | ERefServiceRequest |
| 3 | Create workflow tracking task | ERefTask (focus = ServiceRequest, status = requested) |
| 4 | Search for referrals | Task, ServiceRequest |
| 5 | Record receiving-facility response | ERefTask (update status, businessStatus) |
| 6 | Record encounter, outcome, or onward referral | ERefEncounter, ServiceRequest, Task |
| 7 | Submit as a transaction Bundle | Bundle (type = transaction) |
{:.ph-table}

---

#### Conformance Expectations

This CapabilityStatement uses the `capabilitystatement-expectation` extension (following the **AU Core** and **AU eRequesting** IG convention) to indicate the level of conformance required for each resource, interaction, and search parameter:

| Code | Meaning |
|------|---------|
| **SHALL** | Required. The server MUST support this feature. Missing support is a conformance failure. |
| **SHOULD** | Recommended. The server ought to support this feature unless there is a documented justification. |
| **MAY** | Optional. The server may support this feature. Interoperability may be affected if not supported. |
{:.ph-table}

---

#### Supported Resources

| Resource Type | Profile | Expectation |
|---------------|---------|-------------|
| Patient | [ERefPatient](StructureDefinition-ereferral-patient.html) | **SHALL** |
| Practitioner | [PHCorePractitioner](https://fhir.doh.gov.ph/phcore/StructureDefinition/ph-core-practitioner) | **SHALL** |
| Organization | [PHCoreOrganization](https://fhir.doh.gov.ph/phcore/StructureDefinition/ph-core-organization) | **SHALL** |
| PractitionerRole | [EReferral PractitionerRole](StructureDefinition-ereferral-practitioner-role.html) | **SHALL** |
| ServiceRequest | [EReferral ServiceRequest](StructureDefinition-ereferral-service-request.html) | **SHALL** |
| Task | [EReferral Task](StructureDefinition-ereferral-task.html) | **SHALL** |
| Encounter | [ERefEncounter](StructureDefinition-ereferral-encounter.html) | **SHALL** |
| Condition | [ERefCondition](StructureDefinition-ereferral-condition.html) | **SHOULD** |
| Observation | [ERefObservation](StructureDefinition-ereferral-observation.html) | **SHOULD** |
| Provenance | [EReferral Provenance](StructureDefinition-ereferral-provenance.html) | **SHOULD** |
| RelatedPerson | [EReferral RelatedPerson](StructureDefinition-ereferral-related-person.html) | **MAY** |
| Procedure | [ERefProcedure](StructureDefinition-ereferral-procedure.html) | **MAY** |
| MedicationAdministration | [EReferral MedicationAdministration](StructureDefinition-ereferral-medication-administration.html) | **MAY** |
| Immunization | [ERefImmunization](StructureDefinition-ereferral-immunization.html) | **MAY** |
| DiagnosticReport | (base FHIR) | **MAY** |
{:.ph-table}

---

#### RESTful Interactions

| Resource | read | search-type | create | update |
|----------|------|-------------|--------|--------|
| Patient | SHALL | SHALL | SHOULD | SHOULD |
| Practitioner | SHALL | SHALL | SHOULD | SHOULD |
| Organization | SHALL | SHALL | SHOULD | SHOULD |
| PractitionerRole | SHALL | SHALL | SHOULD | SHOULD |
| ServiceRequest | SHALL | SHALL | SHOULD | — |
| Task | SHALL | SHALL | SHOULD | SHOULD |
| Encounter | SHALL | SHALL | SHOULD | — |
| Condition | SHALL | SHALL | SHOULD | — |
| Observation | SHALL | SHALL | SHOULD | — |
| Provenance | SHALL | SHALL | SHOULD | — |
| RelatedPerson | SHALL | SHALL | MAY | — |
| Procedure | SHALL | SHALL | MAY | — |
| MedicationAdministration | SHALL | SHALL | MAY | — |
| Immunization | SHALL | SHALL | MAY | — |
| DiagnosticReport | SHALL | SHALL | MAY | — |
{:.ph-table}

**System-level interactions:**

| Interaction | Expectation | Description |
|-------------|-------------|-------------|
| transaction | **SHALL** | Atomic submission of referral packages (see [Submission Bundle](Bundle-ExampleERefSubmissionBundle.html)) |
| batch | MAY | Non-atomic batch processing |
{:.ph-table}

---

#### Search Parameters

The following search parameters are supported per resource type. Identifier-based searches enable conditional update in transaction Bundles.

**Master data resources** use identifier searches for idempotent upsert (conditional PUT):

| Resource | Search Params |
|----------|--------------|
| Patient | `_id`, `identifier` (PhilSys/PhilHealth), `name`, `birthdate` |
| Practitioner | `_id`, `identifier` (PRC license), `name` |
| Organization | `_id`, `identifier` (NHFR facility code), `name` |
| PractitionerRole | `_id`, `identifier` (inherited PRC), `practitioner`, `organization` |
{:.ph-table}

**Clinical and workflow resources** enable referrer and receiver to find and update referrals:

| Resource | Search Params |
|----------|--------------|
| ServiceRequest | `_id`, `performer`, `status`, `subject`, `authored` |
| Task | `_id`, `focus`, `status`, `owner`, `requester`, `patient` |
| Encounter | `_id`, `subject`, `based-on` |
| Condition | `_id`, `subject`, `encounter` |
| Observation | `_id`, `subject`, `encounter`, `code` |
| Provenance | `_id`, `target` |
| RelatedPerson | `_id`, `patient` |
| Procedure | `_id`, `subject`, `encounter` |
| MedicationAdministration | `_id`, `subject`, `context` |
| Immunization | `_id`, `patient`, `vaccine-code` |
| DiagnosticReport | `_id`, `subject`, `encounter` |
{:.ph-table}

**Supported `_include` and `_revinclude` parameters:**

| Source Resource | `_include` | `_revinclude` |
|----------------|------------|---------------|
| ServiceRequest | `ServiceRequest:patient`, `ServiceRequest:requester`, `ServiceRequest:performer`, `ServiceRequest:encounter`, `ServiceRequest:supporting-info` | `Task:focus` |
| Task | `Task:focus`, `Task:owner`, `Task:patient`, `Task:requester` | — |
| Encounter | `Encounter:subject`, `Encounter:based-on` | `ServiceRequest:encounter` |
| Condition | `Condition:subject`, `Condition:encounter` | — |
| Observation | `Observation:subject`, `Observation:encounter` | — |
{:.ph-table}

---

#### Security

Implementations **SHOULD** use [SMART on FHIR](http://www.hl7.org/fhir/smart-app-launch/) or equivalent bearer-token authentication. Transport security (TLS) is **REQUIRED** for all production deployments.

See the PH Core IG for base security requirements and the [sample-case-ana-reyes](sample-case-ana-reyes.html) page for the Connectathon test server configuration (`https://cdr.fhirlab.net/fhir`).

---

#### Transaction Bundle Pattern

The eReferral workflow uses a **transaction Bundle** (`Bundle.type = #transaction`) for atomic submission of the complete referral package:

| Entry Type | HTTP Method | Resources | Purpose |
|------------|-------------|-----------|---------|
| Master data | **PUT** (conditional by identifier) | Patient, Practitioner, Organization, PractitionerRole | Idempotent upsert — updates existing or creates new |
| Clinical data | **POST** | ServiceRequest, Task, Encounter, Condition, Observation, Procedure, Provenance, DiagnosticReport | Always creates new resources per referral instance |
{:.ph-table}

Each entry uses `urn:uuid:` identifiers for `fullUrl`, enabling consistent intra-Bundle references. The [Example Submission Bundle](Bundle-ExampleERefSubmissionBundle.html) demonstrates this pattern for the Ana Reyes referral scenario.

---

#### Related Profiles

This CapabilityStatement builds on profiles defined in the **PH Core IG** ([fhir.ph.core](https://fhir.doh.gov.ph/phcore)). All eReferral profiles extend their PH Core equivalents to ensure base-level interoperability across Philippine health information exchange.

---

#### See Also

- [Example Submission Bundle](Bundle-ExampleERefSubmissionBundle.html) — Complete transaction bundle
- [Sample Case: Ana Reyes](sample-case-ana-reyes.html) — End-to-end workflow tutorial
- [Referral Workflow](referral-workflow.html) — Workflow narrative
- [Logical Information Model](logical-information-model.html) — Data model mapping
- [Connectathon Readiness](connectathon-readiness.html) — Test pack and instructions
