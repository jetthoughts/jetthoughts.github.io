# Test-speed research TODO

Scheduled spike (2026-08-01): make the visual suites fast without losing the
signal. Measured findings below; open experiments at the bottom. Pick this up
in a dedicated session — none of the open items are wired yet.

## Measured baseline (host, macOS, `bin/test` warm build)

| Tier | Command | Tests | Wall | State |
|---|---|---|---|---|
| Full system | `bin/rake test:all` | 67 | ~450s (sum of per-test) | 1 error* |
| Critical | `bin/test` | 34 | ~300s | green |
| **Smoke (new)** | `bin/test --smoke` | 17 | **50.5s** | green |
| Docker smoke | `bin/dtest --smoke` | 17 | **41.6s** | 1 stale-red (mermaid)† |

† Docker is ~18% faster than the host on the same 17 tests (41.6s vs 50.5s),
confirming the "Docker is faster" report. The 1 failure is the known-stale
`linux/desktop/blog/special/mermaid_post` baseline (difference_level 0.0693,
byte-identical across runs) — see `project-stale-linux-baselines-pending`, NOT a
smoke-tier defect. Re-record the 10 stale Linux baselines and Docker smoke goes
fully green.

\* `BlogSpecialContentDesktopTest#test_codeblock_language_styles` errors in the
snap_diff Default reporter (`reporters/default.rb:25`, `String#[]` on a Symbol)
whenever a delayed codeblock diff needs formatting. External-gem bug; do not
monkeypatch. It only fires inside the codeblock elephant (below).

## The dominant cost: one test is 44% of the suite

`test_codeblock_language_styles` (desktop + mobile) = **98.8s + 97.2s ≈ 196s**,
44% of the full run. It loops 8 code-fence sections, each an
`assert_stable_screenshot` (multi-capture stability wait) at ~12s/section. The
next-slowest tests are ~12s (mermaid) and everything else averages ~4s.

Smoke tier deliberately excludes it. But for `test:critical` / `test:all` it is
THE target. Open question O1 below.

## Open experiments (not done)

- **O1 — kill the codeblock elephant.** Options, cheapest first:
  (a) capture the 8 sections in ONE full-page screenshot instead of 8 stable
  captures (loses per-section localisation on failure, but the page is static
  text — no font-swap animation to stabilise against); (b) drop
  `stability_time_limit` for these static blocks (they don't animate — the
  stability retries are likely pure waste); (c) split into 8 separate test
  methods so they parallelise (see O2) instead of running serially in one.
  Measure each against unchanged baselines (refactor = zero pixel change).
- **O2 — process-level parallelism.** Thread parallelism is OUT
  (`Capybara.threadsafe = false`, shared `current_driver` global). Process
  sharding is safe: each process boots its own random-port Puma + own Chrome,
  every test writes a distinct baseline PNG. Sketch: extract critical/smoke test
  names (qualified `Class#method` — minitest's `-n` regex matches `pos ===
  "#{klass}##{m}"`, verified in minitest 6.0.6 `filter_runnable_methods`),
  round-robin into N buckets by measured time, spawn N `ruby -Itest <files> -n
  "/^(a|b|c)$/"`, wait-all, fail on any. `JOBS=1` in the dtest container (port
  pin + ~2 emulated CPUs). Expected critical 300s → ~90-120s at N=4.
- **O3 — Docker vs host.** User reports Docker is faster despite amd64
  emulation. Confirm with the smoke number (TBD) and decide whether the routine
  fast gate should run on Docker. Note: 10 Linux baselines (mermaid + codeblocks)
  are stale-red right now — see memory `project-stale-linux-baselines-pending`;
  re-record before trusting a Docker gate.
- **O4 — direct-visit instead of menu-walk.** Several desktop tests reach their
  subject page via `visit "/"` + hover/click when a direct URL exists
  (`test_about_us`, `test_contact_us`, `test_free_consultation`, ...). Each pays
  an extra homepage load. Nav coverage is separately owned by `test_*_menu` /
  hamburger tests, so the menu-walk in page tests is redundant. Gate: unchanged
  baselines.

## Guardrails (do not regress)

- Refactoring must not shift a single baseline pixel — snap_diff compares
  candidate (working tree) vs committed HEAD. A moved baseline = the change was
  wrong.
- Smoke is NOT a milestone/PR gate. `test:critical` (+ `bin/dtest` at PR prep)
  stays the bar. Smoke is the sub-minute "did I break the basics" check.
