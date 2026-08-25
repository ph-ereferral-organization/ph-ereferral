# PH eReferral Data Dictionary

This page provides the authoritative data dictionary for the Philippine eReferral Implementation Guide. It maps all Technical Development Group (TDG) data elements to their corresponding FHIR resources, elements, and value sets.

## Data Dictionary

The table below shows the complete data dictionary mapping all TDG data elements to their corresponding FHIR resources and elements.

<div class="ph-scroll" markdown="1" style="display: block; width: 100%">

{% include data-dictionary-table.md %}

</div>

> **Note:** The source CSV can also be downloaded for offline use or integration with other tools. See the [Download](#download) section below.

---

## Download

The source CSV (TDG FHIR Mapping.csv) is available in the [repository root](https://github.com/ph-ereferral-organization/ph-ereferral/blob/main/TDG%20FHIR%20Mapping.csv).

---

## Data Dictionary Structure

The data dictionary covers all profiles defined in the PH eReferral IG and includes the following columns:

<div class="ph-table" markdown="1">

| Column | Description |
|--------|-------------|
| **Workflow Task** | Referral workflow phase (e.g. Create Referral, Presenting Patient, Referral Triage) |
| **Element ID** | Technical Development Group identifier (e.g. REF-1, REF-9, REF-21) |
| **Data Element** | Human-readable name of the data element |
| **Description/Definition** | Clinical or business definition |
| **Clinical Information Group** | Category grouping for the element (e.g. Sending Practitioner, Receiving Facility) |
| **Is Required** | Whether the element is required, conditional, or optional (Yes/No) |
| **FHIR Element** | The FHIR resource element path carrying this data |
| **Linked By** | How the element is reached from the bundle root (reference chain) |

</div>

---

## Profile Coverage

The data dictionary covers the following eReferral profiles:

<div class="ph-table" markdown="1">

| Profile | TDG Elements | FHIR Resource |
|---------|-------------|---------------|
| [EReferral ServiceRequest](StructureDefinition-ereferral-service-request.html) | REF-1 to REF-21, REF-41 | ServiceRequest |
| [ERefPatient](StructureDefinition-ereferral-patient.html) | REF-21 to REF-30 | Patient |
| [EReferral Task](StructureDefinition-ereferral-task.html) | REF-9, REF-15, REF-17, REF-18 | Task |
| [EReferral Provenance](StructureDefinition-ereferral-provenance.html) | REF-3, REF-4 | Provenance |
| [ERefEncounter](StructureDefinition-ereferral-encounter.html) | (linking resource) | Encounter |
| [ERefObservation](StructureDefinition-ereferral-observation.html) | REF-33 to REF-38 | Observation |
| PHCorePractitioner (from fhir.ph.core) | REF-1, REF-9 | Practitioner |
| [ERefPractitionerRole](StructureDefinition-ereferral-practitioner-role.html) | REF-1, REF-2, REF-5 to REF-11 | PractitionerRole |
| PHCoreOrganization (from fhir.ph.core) | REF-5 to REF-8, REF-10 to REF-12 | Organization |
| [ERefProcedure](StructureDefinition-ereferral-procedure.html) | REF-39 | Procedure |

</div>

---

## How to Use the Data Dictionary

### For Implementers
- Use the **Element ID** column to trace requirements back to the original TDG specification
- Check the **Is Required** column to identify which elements your system must implement
- Review the **FHIR Element** column to see exactly which FHIR element path carries each data element

### For IG Authors
- The CSV file at the repo root serves as the single source of truth for TDG-to-FHIR mappings
- Run `python input/generate_data_dictionary_table.py` to regenerate the table from the CSV
- Updates to the CSV should be reflected in the FSH profile definitions

### For Connectathon Testers
- Reference the data dictionary when validating that test fixtures include all required elements
- Use the **Linked By** column to verify that reference chains in the bundle resolve correctly

---

## Maintenance

The data dictionary is maintained by the PH eReferral IG authoring team. Updates are driven by:

- TDG Technical Working Group on Digital Health decisions
- PH Core profile updates
- Connectathon feedback and implementation experience
- National health data standards revisions

For questions or corrections please open an issue in the [PH eReferral repository](https://github.com/ph-ereferral-organization/ph-ereferral/issues).

---

## See Also

- [EReferral ServiceRequest Profile](StructureDefinition-ereferral-service-request.html)
- [ERefPatient Profile](StructureDefinition-ereferral-patient.html)
- [EReferral Task Profile](StructureDefinition-ereferral-task.html)
- [Sample Case: Ana Reyes eReferral](sample-case-ana-reyes.html)
- [v0.1 Scope and Release Notes](v01-scope.html)
