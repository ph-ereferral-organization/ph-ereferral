# v0.1 Referral Workflow Narrative and State Model

## Purpose and Scope

This page is informative implementation guidance for the v0.1 draft.

This page describes the minimum viable referral workflow for PH eReferral v0.1. It is intended for early implementation, validation, and connectathon-style testing so that implementers can exercise a shared baseline workflow while the broader clinical, operational, and policy decisions continue to mature.

This workflow is not a production policy implementation unless it is formally endorsed by the appropriate clinical, technical, and program owners. It is a testable implementation narrative for the current IG draft.

The minimum path on this page is separated from policy and background material. The workflow tables below are the concrete path expected to be usable for v0.1 authoring and testing; the policy references explain the context and should not, by themselves, be treated as additional v0.1 test steps.

For v0.1, the workflow focuses on:

- creating a referral request from an initiating facility;
- sending the referral request to an intended receiving facility or service;
- tracking that referral through receipt, review, outcome, and closure;
- demonstrating the workflow with the current eReferral request and task records, and the included examples.

The following topics are deferred or not fully resolved in this v0.1 workflow narrative:

- non-response and service-level agreement handling;
- full attachment and security handling;
- final facility and network identification rules;
- back-referral as a required end-to-end workflow.

## Policy and Narrative Basis

This workflow is grounded in the same national policy context summarized on the [WHO SMART Guidelines L1 Basis](who-smart-l1.html) page:

- [DOH Administrative Order No. 2020-0019](https://drive.google.com/file/d/1Uri9Iov3YPw3rc3AidV6dXjv8y_W7ydr/view), *Guidelines on the Service Delivery Design of Health Care Provider Networks*, describes the HCPN context in which referral coordination and service delivery operate.
- [DOH Administrative Order No. 2020-0024](https://law.upd.edu.ph/wp-content/uploads/2020/06/DOH-AO-No-2020-0024.pdf), *Primary Care Policy Framework and Sectoral Strategies*, clarifies the primary care role as navigator, coordinator, and continuing point of contact, and emphasizes continuity and coordination of care.
- [DOH Administrative Order No. 2020-0021](https://law.upd.edu.ph/wp-content/uploads/2020/05/DOH-AO-No_2020-0021.pdf), *Guidelines on Integration of the Local Health Systems into Province-wide and City-wide Health Systems (P/CWHS)*, situates HCPNs and PCPNs within integrated local health-system delivery and includes two-way referrals, patient navigation, records access, and digital technologies for health.

These references inform the workflow scope, especially the emphasis on coordinated care, patient navigation, and records exchange. The v0.1 workflow still remains a draft implementation path until formally endorsed.

## Minimum Viable Workflow Diagram

The following diagram reflects the latest minimum viable workflow discussed by the Clinical Design Group for the v0.1 baseline.

![Minimum viable referral workflow](minimum-viable-workflow.png)

The diagram uses the lanes `Initiator`, `Receiving Service`, and `Recipient`. The `Accept` and `Reject` labels shown in the decision point map to the v0.1 receiving-facility response terms resolved in [Issue #47](https://github.com/ph-ereferral-organization/ph-ereferral/issues/47) by [PR #84](https://github.com/ph-ereferral-organization/ph-ereferral/pull/84): `received`, `accepted`, `rejected`, and `referred-onward`. In this IG, `rejected` is limited to cases where the receiving facility cannot take the case and no onward facility is identified in the same response; capacity-full rerouting is represented as `referred-onward`.

## Actors and Systems

The minimum v0.1 workflow involves the following actors and systems.

| Actor or system | Minimum v0.1 role |
| --- | --- |
| Referring facility / initiating facility | Assesses the patient, creates the referral request, and sends it to a receiving facility or service. |
| Referring practitioner | Acts as the requester for the referral and provides the clinical reason and supporting information. |
| Receiving facility / receiving service | Receives and evaluates the referral, then records the receiving-facility outcome or update. |
| Recipient / receiving clinician or team | Performs clinical triage or clinical review after the receiving service has accepted or otherwise routed the referral for review. |
| Care navigator | May be assigned to coordinate the referral when the local workflow includes this role. In the system this may be represented by linking the navigator to the service request or the task, depending on the implementation pattern. |
| Referral management system / FHIR server / exchange layer | Stores, exchanges, and updates the electronic records used to represent the referral request and workflow state. |

## Minimum Workflow Steps

| Step | Workflow activity | FHIR traceability |
| --- | --- | --- |
| 1 | Patient arrives and presents with a complaint or problem. | Patient demographics are captured and linked to the referral request. |
| 2 | Initiator assesses the patient condition and determines whether referral criteria are satisfied. | Relevant clinical context may be captured as supporting information and linked to the referral request. |
| 3 | If referral criteria are not satisfied, the minimum referral workflow ends. | No formal eReferral request record is required for the v0.1 referral test path. |
| 4 | If referral criteria are satisfied, initiator discusses referral and next steps with the patient, including consent where applicable. | Consent capture is not fully profiled in v0.1. Any consent-related detail should be handled by local policy or a future profile decision. |
| 5 | Initiator creates the referral request and attaches clinical summary or notes. | Create an eReferral request record with the required details such as status, intent, patient, requester, performer, date authored, priority, reason, supporting information, and notes as applicable. |
| 6 | Initiator reviews candidate receiving facilities and sends the referral. | The referral request identifies the intended receiving facility, service, practitioner role, or navigator pattern used by the implementation. |
| 7 | Receiving service receives, registers, or logs the referral and performs referral evaluation. | If workflow tracking is used, create or update the eReferral task record so it references the request and reflects the current workflow state. |
| 8 | Receiving service records the receiving-facility decision or outcome. | Record the receiving-facility outcome using the v0.1 receiving-response terminology: `received`, `accepted`, `rejected`, or `referred-onward`. Non-response is not represented in the current v0.1 examples. |
| 9 | If the referral can proceed, route for clinical triage or review by the recipient and send updates to the sender. | The task record may be used to show who is assigned, when it was last updated, notes, and resulting information. |
| 10 | Next steps after the referral decision are outside the v0.1 minimum path unless explicitly included in a test scenario. | Close the workflow when the referral outcome is known. In the current examples, closure is demonstrated by marking the task as completed, recording the end time, and capturing the resulting information. |

## Known Limitations

This v0.1 workflow page intentionally documents unresolved areas rather than silently making them normative.

- Back-referral is not modeled as a required end-to-end workflow in this MVP page.
- Attachment and security handling are not fully resolved in the current workflow narrative.
- Facility and network identification rules are not finalized here. See [Issue #4](https://github.com/ph-ereferral-organization/ph-ereferral/issues/4) for the facility identification discussion.
- Transport behavior is not defined by this page; implementations may use a referral management system, shared server, or exchange layer pattern agreed for the test event.
- Receiving-facility response terms are defined for v0.1 testing, but production policy endorsement remains outside this informative page.
- Hypertensive Emergency Referral wording is pending terminology sync in [Issue #41](https://github.com/ph-ereferral-organization/ph-ereferral/issues/41).
- Consent, candidate receiving-facility selection rules, and the detailed post-decision recipient workflow are not fully specified in this v0.1 page.
- Non-response and SLA handling are deferred unless explicitly included by a later v0.1 decision.
- Implementers should not infer production policy requirements from this page without formal endorsement.
