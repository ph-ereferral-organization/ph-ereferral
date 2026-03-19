# Philippine eReferral Implementation Guide (PH eReferral IG)

<svg xmlns="http://www.w3.org/2000/svg" role="img" aria-labelledby="title desc" width="100%" viewBox="0 0 1400 200" preserveAspectRatio="xMidYMin meet">
  <title id="title">DRAFT – PH eReferral IG Disclaimer</title>
  <desc id="desc">This guide is a draft and under active development. Not for public consumption.</desc>

  <defs>
    <style>
      text { font-family: "Segoe UI", "Helvetica Neue", Arial, sans-serif; }
      .panel { fill: #fff8d9; stroke: #e0c24f; stroke-width: 2; rx: 10; ry: 10; }
      .header { fill: #c0392b; }
      .title { fill: #ffffff; font-weight: 800; font-size: 40px; letter-spacing: 6px; }
      .body  { fill: #222222; font-size: 30px; font-weight: 600; }
      .muted { fill: #555555; font-size: 30px; }
    </style>
    <filter id="shadow" x="-10%" y="-10%" width="120%" height="120%">
      <feDropShadow dx="0" dy="2" stdDeviation="2" flood-color="rgba(0,0,0,0.18)"></feDropShadow>
    </filter>
    <linearGradient id="headerGloss" x1="0" y1="0" x2="0" y2="1">
      <stop offset="0" stop-color="#d24b3e"></stop>
      <stop offset="1" stop-color="#b33427"></stop>
    </linearGradient>
  </defs>

  <!-- Card panel -->
  <rect class="panel" x="6" y="6" width="1388" height="188" filter="url(#shadow)"></rect>

  <!-- Red header bar with DRAFT -->
  <rect class="header" x="6" y="6" width="1388" height="64" rx="10" ry="10" fill="url(#headerGloss)"></rect>
  <text class="title" x="700" y="46" text-anchor="middle" dominant-baseline="middle">DRAFT</text>

  <!-- Body text -->
  <g transform="translate(0,10)">
    <text class="body" x="66" y="112">This is still under development and not yet active for public consumption.</text>
    <text class="muted" x="66" y="148">Content, data models, and implementation details are subject to change.</text>
    <text class="muted" x="66" y="182"></text>
  </g>

  <!-- Optional right icon -->
  <g transform="translate(1310,100) scale(1.8)" aria-hidden="true">
    <circle cx="0" cy="0" r="30" fill="#f4d03f" stroke="#b7950b" stroke-width="2"></circle>
    <text x="0" y="19" text-anchor="middle" font-size="60" font-weight="700" fill="#c0392b">!</text>
  </g>
</svg>

> **Project Status: In Development**
> This Implementation Guide is under active development and is not yet available for public or production use. Content, data models, and implementation details are subject to change.

## Introduction

The Philippine eReferral Implementation Guide (PH eReferral IG) is a **use case Implementation Guide** that provides a standardized approach for electronic referral workflows within Health Care Provider Networks (HCPNs) in the Philippines. It defines the minimum FHIR-based requirements to support seamless referral of patients between healthcare providers using HL7<sup>&reg;</sup> FHIR<sup>&reg;&copy;</sup> standards.

This IG aligns with the **[Universal Health Care Act (Republic Act 11223)](https://elibrary.judiciary.gov.ph/thebookshelf/showdocs/2/86448)** and **[DOH Administrative Order 2020-0019](https://drive.google.com/file/d/1Uri9Iov3YPw3rc3AidV6dXjv8y_W7ydr/view)**, which mandates interoperable health information systems for integrated care across HCPNs. It enables FHIR-based referral messaging, patient navigation, and back-referral workflows consistent with the AO's Annex D requirements.

This FHIR IG is provided for testing purposes and is not yet suitable for production systems.

## What is a Use Case IG?

A use case Implementation Guide builds upon foundational and core standards to address a specific clinical or administrative workflow. Unlike base or core IGs that establish broad interoperability foundations, a use case IG:

- **Targets a specific workflow** — in this case, the patient referral process between healthcare facilities
- **Profiles core resources for the use case** — constrains and extends PH Core profiles to meet referral-specific requirements
- **Defines actors and interactions** — identifies systems, users, and the exchanges between them
- **Specifies business rules** — documents the rules governing referral lifecycle, status transitions, and required data elements

PH eReferral demonstrates how FHIR resources can be applied to solve a real-world interoperability challenge in the Philippine healthcare system.

## Purpose and Scope

The PH eReferral IG aims to:

1. Enable standardized electronic referral workflows between healthcare facilities within HCPNs
2. Support patient care continuity through interoperable FHIR-based data exchange
3. Implement [UHC Act (RA 11223)](https://elibrary.judiciary.gov.ph/thebookshelf/showdocs/2/86448) and [DOH AO 2020-0019](https://drive.google.com/file/d/1Uri9Iov3YPw3rc3AidV6dXjv8y_W7ydr/view) requirements for referral systems
4. Provide clear, testable specifications for HCPN referral system implementers

This guide focuses on referral-specific FHIR resources (e.g., ServiceRequest, Task, Communication) and their relationships with core clinical and administrative resources (Patient, Practitioner, Organization, Encounter).

It does not define general clinical workflows outside the referral context.

## Usage of this Guide

- **Healthcare Facilities**: Implement eReferral profiles to enable standardized patient referrals
- **Health Information Systems**: Use as a baseline for developing interoperable referral capabilities
- **Developers and Vendors**: Build and validate FHIR-conformant referral systems

## Relationship with Other IGs

PH eReferral fits into the Philippine FHIR IG architecture as a **use case layer** implementation guide that builds upon foundational profiles:

| Layer | IG | Purpose |
|-------|-----|---------|
| Core | [PH Core IG](https://github.com/UP-Manila-SILab/ph-core) | **Base profiles** – Foundational rules, common extensions, and national identifiers (Patient, Practitioner, Organization, Encounter, etc.) |
| **Use Case** | **PH eReferral IG** | **Referral-specific workflows and interactions** – HCPN referral messaging built on PH Core |
| Program | Program-specific IGs | Tailored implementations for specific health programs or facilities |

PH Core provides the **parent/base profiles** used by this IG. PH eReferral:

- Uses PH Core as its foundation – inheriting constraints from PH Core profiles (Patient, Practitioner, Organization, Encounter, etc.)
- Defines referral-specific profiles (ServiceRequest, Task, etc.) for interoperability
- Specifies the referral workflow actors and their interactions
- Documents the complete referral lifecycle from creation to fulfillment
- Provides RESTful API guidance for referral operations

This layered approach enables reuse of common PH Core definitions while addressing the specific needs of HCPN referral workflows mandated by the [UHC Act](https://elibrary.judiciary.gov.ph/thebookshelf/showdocs/2/86448).

## Dependencies

{% include ip-statements.xhtml %}
{% include cross-version-analysis.xhtml %}
{% include dependency-table.xhtml %}
{% include dependency-table-short.xhtml %}
{% include dependency-table-nontech.xhtml %}
{% include globals-table.xhtml %}
