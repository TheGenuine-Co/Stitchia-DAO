---
title: "Role Charter: Executive Secretary (GILC)"
classification: Governance+Ethics+StrategicDesign
validators:
  - role: "Ethics Steward"
  - role: "Governance Architect"
license: Public-Licensed / CodexLinked
tags: [charter, role, executive, secretary, librarian, archive]
links:
  - vault/documents/onboarding_delyan_donovski.md
  - stitchia-protocol-dev/docs/GILC_Fabrica_Blueprint.md
  - stitchia-protocol-dev/scrolls/archive_policy_v1.md
  - stitchia-protocol-dev/scrolls/filing_schema_map.md
---

# Role Charter — Executive Secretary (GILC)

## Purpose
Anchor the administrative backbone of GILC and Digital Fabrica; ensure every governance action is documented, discoverable, and auditable.

## Scope of Authority
- Maintain official records: minutes, resolutions, policies, seals
- Operate Librarian & Archive systems and standards
- Enforce document taxonomy, naming, and retention policies
- Request validator action and track seal completeness

## Core Responsibilities
1) Records & Minutes: Prepare agendas, record decisions, publish minutes
2) Archive & Index: Ingest docs to `vault/documents/`; tag, link, and braid
3) Bookkeeping Evidence: Map documents to financial entries; maintain evidence chains
4) Governance Registry: Keep `ledger.json` current; ensure validator presence
5) Compliance: Apply ethics filters and licensing, coordinate legal reviews

## Operating Standards
- Frontmatter required; validators listed; classification set
- Tags must include domain terms; cross-link related scrolls by id/filename
- Use `./quantum watch --debounce 0.5` during large ingestions

## Interfaces
- Council and Chairs: schedule, publications, procedures
- Data Stewards: dashboard sourcing and updates
- Legal/Licensing: license assertions and third-party sharing

## KPIs
- Sealed rate for governance-impacting scrolls
- Time-to-publish for minutes & resolutions
- Archive completeness index (% tagged + braided)

## Review & Renewal
Annual review of charter and responsibilities with Council; propose upgrades to Archive Policy and validator requirements.
