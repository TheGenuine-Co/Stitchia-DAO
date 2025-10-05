---
title: "Tech Stack – GILC Fabrica (v2.5)"
classification: Governance+Ethics+StrategicDesign
validators:
  - role: "Architect"
license: Public-Licensed / CodexLinked
tags: [tech, blueprint]
links:
  - stitchia-protocol-dev/docs/whitepaper/stitchia_whitepaper_v2.5.md
  - stitchia-protocol-dev/scrolls/genesys_nft_mint.md
---

# Tech Stack – GILC Fabrica

Core Components
---------------
- CLI: `quantum` entrypoint to kernels and workflows
- Ethics Kernel: config profiles (default/strict/permissive)
- Validator Workflow: seals (`approved`/`rejected`) with audit trail and flags
- Dashboard Builder: merges `dashboard` data from scrolls (auto‑computes `members_total`)
- Watcher: debounce batching, full braid rebuild on registry changes
- Exporters: TXT/DOC batch and archive zipper

Runtime Utilities
-----------------
- `quantum serve`: static web server for `frontend/`
- `quantum open`: reveal file locations for quick editing
- `quantum seal`: append validator decisions to the registry ledger
- `quantum profile --list`: view available ethics/runtime profiles

Data Flow
---------
scroll.md -> process -> ledger.json -> braid.json -> dashboard data -> frontend UI

Profiles
--------
`kernel/config.yml` → `profiles` map with overrides applied at runtime via `--profile`.

CLI Additions
-------------
- `serve` to run a static server for the frontend
- `open` to print file paths for quick access
- `seal` to append validator decisions with timestamps
- `build` to regenerate all braids and dashboard JSON

Extensibility
-------------
- Replace RTF exporter with Pandoc/Weasy if available
- Add JSON-LD/graph exports for braids
- Plug role-gated auth for seals and registry write protection
- Optional subgraph/ETL pipeline to sync treasury/proposal sources

Related Docs
------------
- Whitepaper narrative: `docs/whitepaper/stitchia_whitepaper_v2.5.md`
- Validator workflow details: `docs/Validator_Workflow.md`
- Registry schema: `vault/registry/ledger.json`
