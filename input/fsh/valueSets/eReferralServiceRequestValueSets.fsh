ValueSet: EReferralPractitionerRoleCode
Id: vs-practitioner-role
Title: "Practitioner Role VS"
Description: "Designation of referring individual"
* ^url = "https://www.fhir.doh.gov.ph/pheref/ValueSet/practitioner-role"
* ^status = #active
* $sct#158965000 "Doctor"
* $sct#265937000 "Nurse"
* $sct#309453006 "Midwife"
* $sct#46255001 "Pharmacist"
* $sct#386629007 "Medical Technologist"
* $sct#159282002 "Laboratory Aide"
* $sct#106289002 "Dentist"
* $sct#4162009 "Dental Aide"
* $sct#28229004 "Optometrist"
* $phcore-psoc#3253 "Barangay Health Worker"
* $phcore-phcw#PCW "Primary Care Worker"

ValueSet: EReferralServiceCategory
Id: vs-referral-category
Title: "Referral Category VS"
Description: "Referral category (Emergency or Outpatient)"
* ^url = "https://www.fhir.doh.gov.ph/pheref/ValueSet/referral-category"
* ^status = #active
* $sct#73770003 "Emergency"
* $sct#440655000 "Outpatient"

ValueSet: EReferralReason
Id: vs-reason-for-referral-service-type
Title: "Reason for Referral (Service Type) VS"
Description: "Reason for referral (Service type)"
* ^url = "https://www.fhir.doh.gov.ph/pheref/ValueSet/reason-for-referral-service-type"
* ^status = #active
* $sct#11429006 "Consultation"
* $sct#165197003 "Diagnostics"
* $sct#71388002 "Procedure"
* $sct#3457005 "Others"

ValueSet: EReferralRelationshipType
Id: ereferral-relationship-type
Title: "eReferral Relationship Type"
Description: "Relationship roles used for patient contacts, next of kin, emergency contacts, guardians, and accompanying persons in Philippine eReferral."
* ^experimental = true
* ^status = #draft
* $v3-roleCode#NOK "next of kin"
* $v3-roleCode#ECON "emergency contact"
* $v3-roleCode#GUARD "guardian"
* $v3-roleCode#FAMMEMB "family member"
* $v3-roleCode#PRN "parent"
* $v3-roleCode#FTH "father"
* $v3-roleCode#MTH "mother"
* $v3-roleCode#SPS "spouse"
* $v3-roleCode#CHILD "child"
* $v3-roleCode#FRND "unrelated friend"
