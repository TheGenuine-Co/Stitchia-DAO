---
title: "🧬 GILC Fabrica – System Blueprint"
classification: Governance+Ethics+StrategicDesign
validators:
  - role: "Ethics Steward"
  - role: "Governance Architect"
license: Public-Licensed / CodexLinked
tags: [blueprint, governance, ethics, ontology, braid, dashboard]
links:
  - stitchia-protocol-dev/scrolls/creator_cluster_scroll.md
  - stitchia-protocol-dev/scrolls/genesys_nft_mint.md
  - stitchia-protocol-dev/scrolls/dao_dashboard_scroll.md
---

# 🧬 GILC Fabrica – System Blueprint

Executive Summary
-----------------
GILC Fabrica provides a scroll-centric infrastructure for governance work: ethics-aware processing, immutable registry, semantic braids, and live dashboard data streams. The system is CLI-first, file-based, and auditable by design.

Architecture
------------
- Signature Kernel: Computes content signatures and stable scroll IDs (SHA-256).
- Ethics Kernel: Applies configurable ethics filters and validation.
- Ontology Kernel: Extracts titles and simple semantic terms.
- Legal Kernel: Binds license and permissions to each scroll entry.
- Quantum Cascade: Attaches integrity metadata (epoch ΣΩΩ.3.2).
- Registry: JSON ledger of scroll lifecycles at `vault/registry/ledger.json`.
- Braid Connector: Emits semantic topology into `vault/braids/<id>.json`.
- Dashboard Builder: Aggregates dashboard-tagged scrolls to `frontend/data.json`.

Directory Layout
----------------
- `vault/documents/`: author your scrolls here
- `vault/registry/`: ledger + exports
- `vault/braids/`: braid JSON files per scroll
- `kernel/`: ethics, signature, ontology, legal, cascade, dashboard builder
- `stitchia-protocol-dev/scrolls/`: example and domain scrolls (NFT, dashboard)
- `stitchia-protocol-dev/frontend/`: static UI consuming `data.json`

Command Surface (CLI)
---------------------
- `./quantum init [--with-example]`: scaffold vault and optional example
- `./quantum add --title "…" [--out …]`: new scroll from template
- `./quantum process path/to/scroll.md`: ethics+execution processing, auto-braid, dashboard update
- `./quantum braid --id <id>`: regenerate braid for a specific scroll
- `./quantum registry`: list validated scrolls
- `./quantum export --output vault/registry/export.json`: export ledger
- `./quantum preview`: live registry/braid summaries
- `./quantum watch [--interval 1.0] [--debounce 0.5]`: watch, batch process, rebuild dashboard + braids
- `./quantum build`: rebuild all braids and dashboard data
- `./quantum status`: quick summary including flagged counts

Scroll Lifecycle
----------------
1) Author a markdown file with frontmatter (see spec below).
2) Run `quantum process` to register and validate.
3) A braid JSON is generated for the scroll.
4) If the scroll provides `dashboard` data or is tagged `dashboard`, the builder merges it into `frontend/data.json`.
5) Use `watch` for continuous processing during editing.

Frontmatter Spec
----------------
Required/recognized fields:
- `title`: string
- `classification`: string (e.g., Governance+Ethics+StrategicDesign)
- `validators`: array (roles or objects)
- `license`: string or object `{name, permissions}`
- `tags`: array of strings (e.g., `dashboard`, `governance`, …)
- `links`: array of 12-char IDs or repo-relative filenames to cross-link braids
- `dashboard`: inline JSON object with optional sections:
  - `governance`: `{roles: [...], counts: {role: n}, members_total?: n}`
  - `treasury`: `{total_eth, staking_eth, protocol_eth, updated_at}`
  - `proposals`: `{items: [{title, status, age_days}]}`

Ethics Configuration
--------------------
- Config file: `kernel/config.yml`
- Keys:
  - `ethics.forbidden_tokens`: case-insensitive string matches to flag
  - `ethics.blocked_classifications`: list of disallowed `classification`
  - `ethics.require_validators`: bool; when true, scrolls need `validators`

Braids & Linking
----------------
- Each registry entry can connect to others via:
  - Shared tags: creates `type: tag` edges, weighted by overlap
  - Explicit links: creates `type: link` edges when `links` lists target IDs or filenames
- Output format: `vault/braids/<id>.json` with `nodes` and `edges` arrays and `context` metadata.

Dashboard Data Pipeline
-----------------------
- Builder scans dashboard-tagged scrolls and merges their `dashboard` objects.
- Derived values: `members_total` auto-computed from counts if not set.
- Output: `stitchia-protocol-dev/frontend/data.json`
- Frontend: `stitchia-protocol-dev/frontend/index.html` loads the JSON and updates metrics.

Editing Workflow
----------------
- Start: `./quantum_kernel_shell.sh`
- Watch: `./quantum watch` (debounce default 0.5s)
- Preview: `./quantum preview`
- Commit: use your normal git flow; `ledger.json` and braids are versioned.

Governance Roles (Default Legend)
---------------------------------
Anchor • Architect • Steward • Initiator

Roadmap (Suggested)
-------------------
- Frontmatter YAML parser upgrade and schema validation
- Validator signature and seal workflow
- Rich ontology extraction and typed edges in braids
- Static site generator for scrolls and braid visuals
- Optional IPFS-backed artifact store for braids and exports

