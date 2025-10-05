---
title: "Archive Policy v1 — GILC & Digital Fabrica"
classification: Governance+Ethics+StrategicDesign
validators:
  - role: "Ethics Steward"
  - role: "Data Steward"
  - role: "Executive Secretary"
license: Public-Licensed / CodexLinked
tags: [policy, archive, taxonomy, retention, access, governance]
links:
  - stitchia-protocol-dev/docs/GILC_Fabrica_Blueprint.md
  - stitchia-protocol-dev/scrolls/executive_secretary_charter.md
  - vault/documents/onboarding_delyan_donovski.md
---

# Archive Policy v1 — GILC & Digital Fabrica

Purpose
-------
Establish a unified policy for document ingestion, classification, retention, access control, and discovery across GILC and Digital Fabrica.

Scope
-----
Applies to all institutional documents: governance, research, finance, legal, communications, and people operations.

Taxonomy (Document Types)
-------------------------
- Governance: agendas, minutes, resolutions, charters, policies
- Research: papers, datasets, methods, literature reviews
- Finance: invoices, receipts, grants, budgets, attestations
- Legal/IP: contracts, licenses, terms, permissions
- Communications: announcements, public notices, blog posts
- People: onboarding, role charters, performance plans

Naming & Paths
--------------
- File name: `<domain>-<YYYY>-<MM>-<DD>-<slug>.md`
- Suggested folders: `vault/documents/{governance|research|finance|legal|comms|people|programs|assets}`
- IDs: include stable registry ID in braid/registry, not filename

Retention Schedule (Minimum)
----------------------------
- Governance minutes/resolutions: permanent
- Policies/charters: permanent (maintain superseded versions)
- Finance records (invoices/receipts): 7 years
- Research datasets: 5 years or per grant/repository policy
- Legal/IP artifacts: per contract term + 5 years
- General communications: 2 years

Access Levels
-------------
- Public: open docs; default license: Public-Licensed / CodexLinked
- Internal: council + staff; publish summaries publicly when possible
- Restricted: legal/finance; sealed; require data minimization and need-to-know

Ingestion Workflow
------------------
1) Author with frontmatter; include `validators`, `tags`, and `links`
2) Run `./quantum process <file>`; confirm `ethics_status`
3) Request seals (`./quantum seal`) from Ethics Steward + Executive Secretary
4) Ensure braid edges: tags overlap and `links` to related scrolls
5) If dashboard-relevant, include a `dashboard` block

Discovery & Indexing
--------------------
- Tags are mandatory; prefer domain + program + subject tags
- Cross-link by filename or 12-char ID in `links`
- Use `./quantum build` before releases to refresh braids + dashboard data

Compliance & Privacy
--------------------
- Remove PII from public docs; store sensitive content in Restricted scope
- Ensure license statements align with Legal Kernel

Roles & Responsibilities
------------------------
- Executive Secretary: policy owner; ensures compliance and registry hygiene
- Data Steward: taxonomy and discovery quality; dashboard sourcing
- Ethics Steward: ethics review and guardrails

Versioning
----------
- Update this policy via new scroll revisions; link superseded versions in `links`

