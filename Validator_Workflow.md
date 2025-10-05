---
title: "Validator Workflow – Seals (v2.5)"
classification: Governance+Ethics+StrategicDesign
validators:
  - role: "Ethics Steward"
license: Public-Licensed / CodexLinked
tags: [validators, seals]
links:
  - stitchia-protocol-dev/docs/whitepaper/stitchia_whitepaper_v2.5.md
  - stitchia-protocol-dev/scrolls/dao_dashboard_scroll.md
---

# Validator Workflow – Seals

Concept
-------
Validators review scrolls and record decisions (approved/rejected) as sealed entries in the registry with minimal ethics checks.

CLI
---
`./quantum seal --id <scroll_id> --by "Name" --role "Role" --status approved --note "OK"`

Registry Fields
---------------
- `seals`: `[ {by, role, status, note, time} ]`
- `seal_status`: derived: `rejected` if any rejection, else `approved` if any approval, else `none`.
- `ethics_flags`: list generated during processing (e.g., `missing_validators`, `forbidden:<term>`)

Policy Hints
------------
- Require 2+ approvals for sensitive classifications
- Enforce role diversity: at least one Ethics Steward + one Architect
- Auto-flag mismatches between declared `validators` and actual `seals`
- Public artifact publication requires `seal_status=approved` unless Restricted scope

Appendices
----------
- Seal schema reference: `vault/registry/ledger.json`
- Validator roster source: `scrolls/dao_dashboard_scroll.md`
