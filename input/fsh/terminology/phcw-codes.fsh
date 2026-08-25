CodeSystem: PHCorePHCW
Id: PHCW
Title: "PHCW"
Description: "Philippines Healthcare Workers Code System"
// NOTE: URL uses phcore namespace (per ontoserver tx.fhirlab.net).
// Tracked in https://github.com/ph-ereferral-organization/ph-ereferral/issues/140
// special-url workaround in sushi-config.yaml suppresses canonical mismatch.
* ^url = "https://fhir.doh.gov.ph/phcore/CodeSystem/PHCW"
* ^status = #active
* ^experimental = false
* ^caseSensitive = true
* ^content = #fragment

* #PCW "Primary Care Worker" "Primary Care Worker"
