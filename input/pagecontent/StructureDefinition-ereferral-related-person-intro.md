### EReferral RelatedPerson Profile

The **EReferral RelatedPerson** profile represents an optional patient contact exchanged as a separate resource in the Philippine eReferral workflow.

Use this profile when next-of-kin, emergency contact, guardian, or accompanying-person details need to be represented independently from `Patient.contact`. The profile maps to TDG element **REF-29: Accompanied By / Next of Kin**.

#### Scope

This profile supports:

- next of kin and emergency contacts
- guardians for pediatric or dependent patients
- accompanying persons during referral
- persons to contact regarding referral coordination

#### PH Core Alignment

This profile extends **PHCoreRelatedPerson**. PH Core already provides the Philippine localization for RelatedPerson, including PH Core address support. EReferral adds referral-specific must-support expectations and an extensible binding for common relationship roles.

#### Optionality

The RelatedPerson resource is optional in an eReferral exchange. Systems may use `Patient.contact` for simple contact details. When a separate RelatedPerson resource is exchanged, `patient` remains required because FHIR R4 requires every RelatedPerson to identify the patient it is related to.

#### Must Support Elements

| Element | Cardinality | Description |
|---------|-------------|-------------|
| `patient` | 1..1 | Patient associated with this contact |
| `relationship` | 0..* | Relationship to the patient |
| `name` | 0..* | Name of the related person |
| `telecom` | 0..* | Contact details |
| `address` | 0..* | Address |
| `gender` | 0..1 | Administrative gender |
| `birthDate` | 0..1 | Date of birth |
| `period` | 0..1 | Relationship validity period |

#### Examples

- [Example ERefRelatedPerson - Next of Kin](RelatedPerson-ExampleERefRelatedPersonNextOfKin.html)
- [Example ERefRelatedPerson - Accompanying Person](RelatedPerson-ExampleERefRelatedPersonAccompanying.html)
