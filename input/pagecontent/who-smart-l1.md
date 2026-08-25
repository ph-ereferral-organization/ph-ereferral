# WHO SMART Guidelines L1 Basis for the PH eReferral IG

## Purpose

This page explains the **WHO SMART Guidelines Level 1 (L1)** basis used for the Philippine eReferral Implementation Guide (PH eReferral IG).

In this implementation guide, L1 is the **narrative and policy foundation** for the eReferral use case. It provides the high-level basis for why referral interoperability matters, what policy and service-delivery context applies, and which source references should anchor later design work.

This page is intentionally **foundational rather than exhaustive**. It is not a reproduction of WHO source material or a complete policy compendium. Its role is to provide a concise, traceable starting point for contributors, reviewers, and implementers.

## Why L1 Matters in This IG

WHO SMART Guidelines start from narrative guidance and then move toward increasingly structured and implementation-ready artefacts. For the PH eReferral IG, that means the work should not begin from FHIR profiles alone. It should begin from the policy, workflow, and service-delivery basis that explains:

- why referral and back-referral matter in the Philippine context;
- how Health Care Provider Networks (HCPNs) frame coordination of care;
- how primary care acts as the navigator, coordinator, and initial and continuing point of contact within the health system;
- which national references establish the direction for interoperable referral processes; and
- how later structured requirements should remain traceable to those narrative sources.

Using an L1 foundation helps keep the PH eReferral IG aligned to real program and system needs instead of treating the IG as a purely technical exercise.

## Intended Use of This Page

This page should be used as a **reference and orientation page** for the PH eReferral IG. It is meant to:

- summarize the narrative basis and guiding references used by this repository;
- clarify the role and boundaries of L1 in the PH eReferral context;
- support traceability from narrative guidance to later structured artefacts; and
- provide a stable entry point for contributors who are new to WHO SMART work.

This page should **summarize and point to authoritative references**, not replace them.

## PH eReferral L1 Basis

The PH eReferral IG is being developed in a context shaped by Philippine universal health care policy and HCPN service-delivery design.

At a minimum, the current L1 basis for this IG includes:

1. [**Republic Act No. 11223** (Universal Health Care Act)](https://elibrary.judiciary.gov.ph/thebookshelf/showdocs/2/86448), which establishes the national universal health care policy direction and frames integrated and comprehensive health-system delivery.
2. [**DOH Administrative Order No. 2020-0019**](https://drive.google.com/file/d/1Uri9Iov3YPw3rc3AidV6dXjv8y_W7ydr/view), *Guidelines on the Service Delivery Design of Health Care Provider Networks*, which describes the HCPN context in which referral coordination and service delivery operate.
3. [**DOH Administrative Order No. 2020-0024**](https://law.upd.edu.ph/wp-content/uploads/2020/06/DOH-AO-No-2020-0024.pdf), *Primary Care Policy Framework and Sectoral Strategies*, which clarifies the primary care role as navigator, coordinator, and continuing point of contact, and emphasizes continuity and coordination of care.
4. [**DOH Administrative Order No. 2020-0021**](https://law.upd.edu.ph/wp-content/uploads/2020/05/DOH-AO-No_2020-0021.pdf), *Guidelines on Integration of the Local Health Systems into Province-wide and City-wide Health Systems (P/CWHS)*, which situates HCPNs and PCPNs within integrated local health-system delivery and explicitly includes two-way referrals, patient navigation, records access, and digital technologies for health.

Together, these sources provide the narrative basis for treating eReferral as part of coordinated, standards-aligned, network-based care delivery rather than as a standalone messaging feature.

## Key Narrative Basis from the Referenced Sources

The current source set indicates the following narrative basis for PH eReferral:

- [**RA 11223 / UHC policy direction**](https://elibrary.judiciary.gov.ph/thebookshelf/showdocs/2/86448): health-system design should support integrated, comprehensive, and coordinated care rather than fragmented service delivery.
- [**AO 2020-0019 / HCPN design**](https://drive.google.com/file/d/1Uri9Iov3YPw3rc3AidV6dXjv8y_W7ydr/view): HCPNs are expected to deliver continuous health care from primary to tertiary levels through safe, efficient, and coordinated mechanisms.
- [**AO 2020-0019 / referrals**](https://drive.google.com/file/d/1Uri9Iov3YPw3rc3AidV6dXjv8y_W7ydr/view): the order explicitly calls for a functional referral system, localized referral protocols, patient navigation and coordination, standardized communication processes, a uniform referral form, and a back-referral form with follow-up and home instructions.
- [**AO 2020-0019 / interoperability**](https://drive.google.com/file/d/1Uri9Iov3YPw3rc3AidV6dXjv8y_W7ydr/view): HCPNs are expected to have a patient record management system with interoperable electronic medical records capable of real-time information sharing across member facilities.
- [**AO 2020-0024 / primary care policy**](https://law.upd.edu.ph/wp-content/uploads/2020/06/DOH-AO-No-2020-0024.pdf): primary care is positioned as the navigator, coordinator, and initial and continuing point of contact, with continuity of care across health conditions and levels of care.
- [**AO 2020-0021 / integrated local systems**](https://law.upd.edu.ph/wp-content/uploads/2020/05/DOH-AO-No_2020-0021.pdf): PCPNs are described as the foundation of HCPNs and are responsible for serving as initial contact and navigator, coordinating patients to facilitate two-way referrals, and supporting access across levels of care, including the use of digital technologies for health.

These points are the main reason this implementation guide needs a dedicated L1 basis page. They establish that referral interoperability in this project is rooted in coordinated service delivery, networked care, patient navigation, and continuity of care, not only in technical message exchange.

## What This Means for the PH eReferral IG

For this implementation guide, the L1 basis should be understood as establishing the following project direction:

- the PH eReferral IG supports referral and back-referral as part of coordinated care across HCPNs;
- the IG should treat primary care and PCPN functions as central to referral coordination and continuity of care;
- the IG should reflect the service-delivery and interoperability needs implied by national policy and HCPN design guidance;
- the IG should support standardized referral communication, patient navigation, and records exchange across participating facilities;
- the narrative basis should remain visible and traceable as the project moves into more structured requirements and technical implementation artefacts; and
- policy and workflow intent should be distinguished from FHIR-specific design decisions.

## Boundaries of This Page

This page does **not**:

- reproduce the full text of WHO SMART materials;
- restate the full text of Philippine laws, administrative orders, or manuals;
- define all L2 Digital Adaptation Kit (DAK) content;
- define full workflow logic, data elements, decision-support logic, or indicators; or
- act as the final source of technical conformance requirements.

Instead, this page provides the narrative basis that later work can refine into structured requirements and implementation artefacts.

## Relationship to WHO SMART L2 and L3 Work

The PH eReferral IG should treat this L1 page as the narrative foundation for downstream work.

<div class="ph-table" markdown="1">

| SMART level | Role in this project | Expected output in PH eReferral work |
|-------------|----------------------|--------------------------------------|
| **L1 Narrative guidance** | Describes the policy, service-delivery, and guideline basis for the use case | This page and linked source references |
| **L2 DAK / structured requirements** | Converts narrative guidance into operational and structured requirements | Business processes, actors, data needs, rules, and other structured artefacts |
| **L3 FHIR IG / technical implementation** | Expresses computable and testable implementation content | FHIR profiles, examples, terminology bindings, interactions, and validation-ready guidance |

</div>

This separation matters. The PH eReferral IG should not collapse L1, L2, and L3 into one page or one type of artefact. Each layer serves a different purpose and should remain traceable to the layer above it.

## Traceability Expectations

To support future alignment with L2 DAK and L3 IG work, narrative statements on this page should be traceable to authoritative references.

Where later project artefacts introduce a workflow rule, actor responsibility, business requirement, or technical constraint, those artefacts should identify whether the basis comes from:

- a WHO SMART narrative reference;
- a Philippine policy or administrative source;
- a project-level interpretation needed for the PH eReferral use case; or
- a later design decision introduced during L2 or L3 work.

## PH-Specific Interpretation Notes

The following interpretation points apply to this page:

- This page is a **project-oriented summary** of the L1 basis for the PH eReferral IG.
- Philippine policy and HCPN references are used here as the immediate narrative basis for the local implementation context.
- If the repository later adopts additional WHO SMART source references, those should be added explicitly rather than assumed.
- Any PH-specific interpretation or adaptation beyond the cited source materials should be labeled clearly in future revisions.

## Authoritative References

### WHO SMART references

- [WHO SMART Guidelines overview](https://www.who.int/teams/digital-health-and-innovation/smart-guidelines/)
- [WHO SMART Guidelines: Digital Adaptation Kits overview](https://www.who.int/publications/m/item/who-digital-accelerator-kits)

### Philippine references currently used by this project

- [Republic Act No. 11223, Universal Health Care Act](https://elibrary.judiciary.gov.ph/thebookshelf/showdocs/2/86448)
- [DOH Administrative Order No. 2020-0019, Guidelines on the Service Delivery Design of Health Care Provider Networks](https://drive.google.com/file/d/1Uri9Iov3YPw3rc3AidV6dXjv8y_W7ydr/view)
- [DOH Administrative Order No. 2020-0019-A, Amendment to Administrative Order No. 2020-0019 dated May 14, 2020 Entitled "Guidelines on the Service Delivery Design of Health Care Provider Networks"](https://drive.google.com/file/d/1bkQLF3YU15UZuRHJKlMGBgcJLIMl9ESp/view)
- [DOH Administrative Order No. 2020-0024, Primary Care Policy Framework and Sectoral Strategies](https://law.upd.edu.ph/wp-content/uploads/2020/06/DOH-AO-No-2020-0024.pdf)
- [DOH Administrative Order No. 2020-0021, Guidelines on Integration of the Local Health Systems into Province-wide and City-wide Health Systems (P/CWHS)](https://law.upd.edu.ph/wp-content/uploads/2020/05/DOH-AO-No_2020-0021.pdf)
- [Public Health Unit Manual of Operations](https://drive.usercontent.google.com/download?id=18TW6zePVfbH6Ich2XuyS6Jqq3rPWChjG&authuser=0&acrobatPromotionSource=gdrive_chrome-list)

### Additional project references to confirm

- `[Placeholder]` Additional WHO SMART source reference(s) adopted by the project
- `[Placeholder]` Additional DOH / operational guidance reference(s) used to refine the PH eReferral narrative basis
- `[Placeholder]` Repository location for linked L2 DAK artefacts
- `[Placeholder]` Repository location for linked L3 FHIR IG artefacts

## Maintenance Notes

This page should be updated when:

- the project confirms additional WHO SMART references as normative inputs;
- the repository establishes linked L2 artefacts that should be referenced here;
- the repository establishes linked L3 artefacts that should be referenced here; or
- the project agrees on PH-specific interpretation notes that should be documented for traceability.
