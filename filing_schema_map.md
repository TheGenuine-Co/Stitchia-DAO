---
title: "Filing Schema – GILC & Digital Fabrica"
classification: Governance+Ethics+StrategicDesign
validators:
  - role: "Executive Secretary"
  - role: "Data Steward"
license: Public-Licensed / CodexLinked
tags: [filing, schema, taxonomy, index, governance]
links:
  - stitchia-protocol-dev/scrolls/archive_policy_v1.md
  - stitchia-protocol-dev/scrolls/executive_secretary_charter.md
---

# Filing Schema – GILC & Digital Fabrica

Purpose
-------
Define canonical entities and fields for indexing and discovery across the archive.

Entity Maps (Core)
------------------
- People
  - Keys: `person_id`, `name`, `roles[]`, `start_date`, `status`
  - Links: onboarding scroll, role charters, seals
- Roles
  - Keys: `role_id`, `name`, `scope`, `kpis[]`, `owner`
  - Links: charter scrolls, policies
- Programs
  - Keys: `program_id`, `name`, `objective`, `owner`, `budget_ref`
  - Links: proposals, reports, dashboards
- Proposals
  - Keys: `proposal_id`, `title`, `status`, `created_at`, `decision_at`
  - Links: decision minutes, sponsor docs, treasury entries
- Meetings
  - Keys: `meeting_id`, `date`, `chair`, `participants[]`
  - Links: agenda scroll, minutes scroll, resolutions
- Assets
  - Keys: `asset_id`, `type`, `owner`, `license`, `location`
  - Links: IP/Legal scrolls, datasets
- Treasury Entries
  - Keys: `entry_id`, `date`, `amount`, `currency`, `category`
  - Links: evidence docs (invoices/receipts), approvals, resolutions

Suggested Folders
-----------------
`vault/documents/people/`, `vault/documents/roles/`, `vault/documents/programs/`, `vault/documents/proposals/`, `vault/documents/meetings/`, `vault/documents/assets/`, `vault/documents/finance/`

Naming
------
`<entity>-<ID>-<YYYY-MM-DD>-<slug>.md` (e.g., `proposal-TGC-P-2025-001-dia-fellowship.md`)

Indexing Requirements
---------------------
- Every scroll must include: `title`, `classification`, `validators`, `tags`, `links`
- People/Role scrolls must link both ways (onboarding ↔ charter)
- Proposals must link decisions and treasury evidence

Quality Metrics
---------------
- Coverage: % scrolls meeting frontmatter minimums
- Connectivity: average braid edges per scroll
- Freshness: days since last update per program

