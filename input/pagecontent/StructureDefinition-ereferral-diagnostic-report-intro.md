### EReferral DiagnosticReport

The **EReferral DiagnosticReport** profile represents diagnostic reports shared as supporting clinical information in a Philippine eReferral. Reports are linked from `ServiceRequest.supportingInfo`.

The minimum requirement is `DiagnosticReport.presentedForm` with an `Attachment` carrying the complete report content. `presentedForm.contentType` is required when `presentedForm` is populated.

Complete attachments can be added through `presentedForm`.

#### Report Attachments

Complete report attachments use `presentedForm`. Supported MIME types are:

| File type | MIME type |
|-----------|-----------|
| PDF or PDF/A | `application/pdf` |
| PNG | `image/png` |
| JPG or JPEG | `image/jpeg` |
| GIF | `image/gif` |

Attachments should not exceed **5 MB (5,242,880 bytes)**. The profile applies this as a warning when `Attachment.size` is populated. Implementers should prefer `Attachment.url` for externally retrievable report content or use a small payload when inline `Attachment.data` is necessary; large base64 examples are intentionally excluded.

The supported MIME types remain narrative guidance for v0.1. `Attachment.contentType` keeps its standard FHIR R4 required binding to the MIME Types value set; PeReF does not add a custom MIME CodeSystem or ValueSet.

This is a simple eReferral attachment approach aligned with [FHIR R4 DiagnosticReport](https://hl7.org/fhir/R4/diagnosticreport.html) and informed by [NHS e-Referral file attachment guidance](https://digital.nhs.uk/services/e-referral-service/api/updates-and-releases/roadmap/file-attachments), adapted for PeReF referral supporting information.
