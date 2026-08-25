CodeSystem: PHCorePSOC
Id: PSOC
Title: "PSOC"
Description: "Philippine Standard Occupational Classification (fragment — healthcare-relevant codes)"
// NOTE: URL uses phcore namespace (per ontoserver tx.fhirlab.net).
// Tracked in https://github.com/ph-ereferral-organization/ph-ereferral/issues/140
// special-url workaround in sushi-config.yaml suppresses canonical mismatch.
* ^url = "https://fhir.doh.gov.ph/phcore/CodeSystem/PSOC"
* ^status = #active
* ^experimental = false
* ^caseSensitive = true
* ^content = #fragment

* #2211 "Generalist medical practitioners" "Generalist medical practitioners"
* #2212 "Specialist medical practitioners" "Specialist medical practitioners"
* #2221 "Nursing professionals" "Nursing professionals"
* #2222 "Midwifery professionals" "Midwifery professionals"
* #2261 "Dentists" "Dentists"
* #2262 "Pharmacists" "Pharmacists"
* #2267 "Optometrists and ophthalmic opticians" "Optometrists and ophthalmic opticians"
* #1342 "Health services managers" "Health services managers"
* #3253 "Community health workers" "Community health workers"
* #5321 "Healthcare assistants" "Healthcare assistants"
