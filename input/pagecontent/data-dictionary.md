# PH eReferral Data Dictionary

This page provides the authoritative data dictionary for the Philippine eReferral Implementation Guide. It maps all Technical Development Group (TDG) data elements to their corresponding FHIR resources, elements, value sets, and cardinality constraints.

## Data Dictionary

The table below shows the complete data dictionary mapping all TDG data elements to their corresponding FHIR resources, elements, value sets, and cardinality constraints.

{% include data-dictionary-table.html %}

> **Note:** The full CSV can also be downloaded for offline use or integration with other tools. See the [Download](#download) section below.

---

## Download

- [Download data-dictionary.csv](data-dictionary.csv)

---

## Data Dictionary Structure

The data dictionary covers all profiles defined in the PH eReferral IG and includes the following columns:

<div class="ph-table" markdown="1">

| Column | Description |
|--------|-------------|
| **TDG ID** | Technical Development Group identifier (e.g. REF-1 REF-21) |
| **Data Element** | Human-readable name of the data element |
| **Definition** | Clinical or business definition |
| **FHIR Resource** | The FHIR resource that carries this data element |
| **FHIR Path** | The full FHIR element path |
| **Cardinality** | Minimum and maximum occurrences (e.g. 1..1 0..*) |
| **Data Type** | FHIR data type (e.g. Reference CodeableConcept dateTime) |
| **Value Set / Binding** | Bound value set identifier system or fixed value |
| **Must Support** | Whether the element is marked Must Support in the IG |
| **Notes** | Implementation notes references and edge cases |

</div>

---

## Profile Coverage

The data dictionary covers the following eReferral profiles:

<div class="ph-table" markdown="1">

| Profile | TDG Elements | FHIR Resource |
|---------|-------------|---------------|
| [EReferral ServiceRequest](StructureDefinition-ereferral-service-request.html) | REF-1 to REF-21 REF-40 REF-96 REF-97 | ServiceRequest |
| [ERefPatient](StructureDefinition-ereferral-patient.html) | REF-21 to REF-30 | Patient |
| [EReferral Task](StructureDefinition-ereferral-task.html) | REF-9 REF-41 to REF-48 REF-91 to REF-93 | Task |
| [EReferral Provenance](StructureDefinition-ereferral-provenance.html) | REF-3 REF-4 REF-76 to REF-83 | Provenance |
| [ERefEncounter](StructureDefinition-ereferral-encounter.html) | REF-49 to REF-53 REF-89 to REF-90 | Encounter |
| [ERefObservation](StructureDefinition-ereferral-observation.html) | REF-31 REF-33 to REF-38 REF-66 to REF-71 REF-94 to REF-95 | Observation |
| [ERefMedicationAdministration](StructureDefinition-ereferral-medication-administration.html) | REF-39 REF-72 to REF-75 | MedicationAdministration |
| [ERefImmunization](StructureDefinition-ereferral-immunization.html) | REF-54 to REF-57 | Immunization |
| [ERefRelatedPerson](StructureDefinition-ereferral-related-person.html) | REF-29 REF-58 to REF-65 | RelatedPerson |
| [ERefPractitionerRole](StructureDefinition-ereferral-practitioner-role.html) | REF-1 REF-2 REF-5 to REF-11 REF-84 to REF-88 | PractitionerRole |

</div>

---

## How to Use the Data Dictionary

### For Implementers
- Use the **TDG ID** column to trace requirements back to the original TDG specification
- Check the **Must Support** column to identify which elements your system must implement
- Review the **Value Set / Binding** column to ensure your coded values conform to the IG

### For IG Authors
- The CSV file serves as the single source of truth for TDG-to-FHIR mappings
- Updates to the CSV should be reflected in the FSH profile definitions
- The CSV is versioned through the IG build process

### For Connectathon Testers
- Reference the data dictionary when validating that test fixtures include all required elements
- Use the **Cardinality** column to verify that required elements are present (1..1) and optional elements are handled correctly

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
- [v0.1 Connectathon Readiness](connectathon-readiness.html)
- [v0.1 Scope and Release Notes](v01-scope.html)
