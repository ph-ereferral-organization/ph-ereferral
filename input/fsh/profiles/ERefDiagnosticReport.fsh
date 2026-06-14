// PH Core does not currently publish a DiagnosticReport profile, so this
// eReferral profile derives directly from the FHIR R4 base resource.
// TDG REF-40 maps laboratory result attachments to presentedForm and links
// the report from ServiceRequest.supportingInfo.
Profile: ERefDiagnosticReport
Parent: DiagnosticReport
Id: ereferral-diagnostic-report
Title: "EReferral DiagnosticReport"
Description: "Diagnostic report profile for laboratory, diagnostic imaging, pathology, and histopathology reports shared as supporting clinical information in a Philippine eReferral."

* ^status = #draft
* ^experimental = true
* ^purpose = "To support referral handover of diagnostic reports that summarize or group diagnostic findings, link to structured atomic Observation results when available, and carry a complete formatted report attachment when needed."

* basedOn MS
* basedOn insert ObligationOptional
* basedOn only Reference(ERefServiceRequest)

* subject MS
* subject insert ObligationOptional

* subject only Reference(ERefPatient)



* performer only Reference(PHCorePractitioner or PHCoreOrganization)

* result only Reference(ERefObservation)

* presentedForm MS
* presentedForm insert ObligationOptional
  * ^short = "Complete formatted diagnostic report"
  * ^definition = "The complete report as an attachment. Supported formats are PDF or PDF/A (application/pdf), PNG (image/png), JPG/JPEG (image/jpeg), and GIF (image/gif). Attachments should not exceed 5 MB (5,242,880 bytes)."

* presentedForm.contentType 1..1

* obeys eref-diagnosticreport-attachment-size

Invariant: eref-diagnosticreport-attachment-size
Description: "Presented report attachments should not exceed 5 MB when Attachment.size is populated."
Severity: #warning
Expression: "presentedForm.all(size.empty() or size <= 5242880)"
