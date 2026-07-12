# Superseded 2026-07-12

Everything in this folder encodes the original Oct-2025 plan — "eliminate 70-80%
CSS duplication (27,094–31,536 lines)" via shared-foundation extraction and
consolidation — which was falsified on compiled+gzip evidence during Phase 1
(WP1.2/WP1.4) and the Phase 2 audits (sprint 7, 2026-07-12): PurgeCSS runs per
bundle, so each page already ships only its own FL subset, and any shared
foundation is net-negative on first-visit transfer size. The `.fl-visible`
duplication claim measured 41.9%, not 90-95%; the "7 FL layout files" count was
actually 17 (16 after the e93d9b85 bundle merge).

Kept for history only. The current authority is
`../../2026-07-12-css-maintainability-redesign.md` (strangler rewrite plan) and
`../../TASK-TRACKER.md`.
