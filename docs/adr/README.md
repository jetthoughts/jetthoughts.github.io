# ADRs — site-wide architecture decisions

**This dir is the ONE home for site-wide ADRs** (numbered `NNNN-slug.md`). Project-scoped ADRs live inside their project's `30-39-architecture-design/` (e.g. 2605's 30.09 visual-system ADR) — do not duplicate them here.

**Site decisions only.** A decision about the *business* — the operating process, pricing, what
the AI setup may do, goals and kill criteria — belongs in the PKM vault, not here. The vault owns
decisions; this repo reads them (`~/Documents/pkm/AGENTS.md`, Code Repositories). ADR-0008
(operating process) and ADR-0009 (freeing founder hours) were written here by mistake on
2026-08-29 and now live at `~/Documents/pkm/adr-0008-operating-process-for-jetthoughts.md` and
`adr-0009-freeing-founder-hours.md`. **The number space is shared across both homes** — those two
numbers are taken, so the next site ADR is `0010`. Renumbering breaks citations; do not.

The test: would this decision still matter if the website were deleted? Yes → vault. No → here.

- `0001-css-component-simplification.md`
- `0002-css-validation-checklist.md` (renamed 2026-08-08; was a second `0001-`)
- `0003-site-design-system.md` — one design system for site chrome ("Rescue Room")
- `0004-static-site-experimentation.md` — what gets A/B tested, what cannot be, what replaces it
- `0005-reusable-ai-instruction-layer.md` — extract generic skills/agents/contract as a Claude Code plugin; repos keep thin bindings
- `0006-clean-slate-dual-run.md` — freeze legacy, build v2 on its own rail, stage at `/next/`; supersedes ADR-0003's propagate-into-legacy mechanism
