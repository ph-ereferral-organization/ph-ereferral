Instance: ExampleERefDiagnosticReportPDF
InstanceOf: ERefDiagnosticReport
Usage: #example
Title: "Example Laboratory Diagnostic Report with PDF Attachment"
Description: "Example laboratory DiagnosticReport with complete report attachment through presentedForm, linked to an eReferral ServiceRequest and patient."

* status = #final
* code = $loinc#11502-2 "Laboratory report"
* basedOn = Reference(ExampleERefServiceRequest)
* subject = Reference(ERefPatientExample)
* performer = Reference(ExampleERefReferringFacility)
* presentedForm.contentType = #application/pdf
* presentedForm.url = "https://example.org/fhir/reports/laboratory-report-2025-001.pdf"
* presentedForm.title = "Laboratory Report 2025-001"
