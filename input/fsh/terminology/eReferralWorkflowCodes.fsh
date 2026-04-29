// eReferral workflow terminology used to represent receiving-facility responses
// and related workflow outputs.

CodeSystem: EReferralWorkflowCS
Id: ereferral-workflow
Title: "eReferral Workflow Code System"
Description: "Local workflow codes for Philippine eReferral receiving-facility responses and related referral coordination events."
* ^status = #draft
* ^experimental = false
* ^caseSensitive = true
* ^content = #complete

* #received "Received" "The receiving facility has acknowledged receipt of the referral and is reviewing whether it can take the case."
* #accepted "Accepted" "The receiving facility can take the case and has given a positive transfer or service response."
* #rejected "Rejected" "The receiving facility cannot take the case and no onward receiving facility is identified in the same response."
* #referred-onward "Referred onward" "The receiving facility cannot take the case and directs the patient or referral to another specified facility."
* #capacity-full "Capacity full" "The receiving facility reports that capacity is full."
* #onward-referral-request "Onward referral request" "A ServiceRequest created or identified as the next referral request after the initial receiving facility refers the case onward."
* #consultation-summary "Consultation summary" "A summary of the referral service outcome."

ValueSet: EReferralReceivingResponse
Id: ereferral-receiving-response
Title: "eReferral Receiving Facility Response"
Description: "Response states used by a receiving facility after referral receipt in the PH eReferral workflow."
* ^status = #draft
* ^experimental = false
* EReferralWorkflowCS#received "Received"
* EReferralWorkflowCS#accepted "Accepted"
* EReferralWorkflowCS#rejected "Rejected"
* EReferralWorkflowCS#referred-onward "Referred onward"
