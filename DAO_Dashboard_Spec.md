---
title: "DAO Dashboard – Data Spec (v2.5)"
classification: Governance+Ethics+StrategicDesign
validators:
  - role: "Architect"
license: Public-Licensed / CodexLinked
tags: [dashboard, data-spec]
links:
  - stitchia-protocol-dev/scrolls/dao_dashboard_scroll.md
  - stitchia-protocol-dev/docs/whitepaper/stitchia_whitepaper_v2.5.md
---

# DAO Dashboard – Data Spec (v2.5)

This document specifies the data schema surfaced in the DAO Dashboard. It aligns with scrolls:

- `stitchia-protocol-dev/scrolls/dao_dashboard_scroll.md`
- `stitchia-protocol-dev/scrolls/genesys_nft_mint.md`

## Governance (Spiral Roles)
- `roles`: array of role names. Default: ["Anchor","Architect","Steward","Initiator"]
- `counts`: object mapping role -> integer
- `members_total`: integer (derived if absent using `sum(counts.values())`)

Example:
```json
{
  "roles": ["Anchor","Architect","Steward","Initiator"],
  "counts": {"Anchor": 24, "Architect": 18, "Steward": 30, "Initiator": 17},
  "members_total": 89
}
```

## Treasury
- `total_eth`: number
- `staking_eth`: number
- `protocol_eth`: number
- `updated_at`: ISO8601
- `source`: optional citation handle (URL, IPFS hash, or registry id)

## Proposals
- `items`: list of objects with fields:
  - `title`: string
  - `status`: enum ["Active","In Progress","Completed"]
  - `age_days`: integer
  - `source`: optional URL or id for audit trails

## Wallet
- `connected`: boolean
- `address`: string | null
- `last_synced_at`: optional ISO8601 for wallet polling cadence

## Ethics Guardrails
- Avoid financial return promises; focus on governance/participation.
- Show sources for metrics and last update timestamps.
- Provide provenance for counts and treasury where possible (`source` fields).
- Retain historical snapshots in `frontend/data-history/` if deltas drive governance triggers.
