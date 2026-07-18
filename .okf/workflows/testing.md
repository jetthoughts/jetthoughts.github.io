---
type: Playbook
title: Test Suite & Gates
description: Minitest-based test suite structure and the mandatory test/visual-regression gates for HTML/CSS/template changes.
resource: Rakefile
tags: [testing, minitest, ci]
timestamp: 2026-07-12T00:00:00Z
---

# Overview

Tests use Minitest under `test/`, driven by `Rakefile` (`Rake::TestTask`).
`test/test_helper.rb` sets `SYNC_ENV=test`, a fake `DEVTO_API_KEY`, and
loads `lib/` onto `$LOAD_PATH`.

| Rake task | Pattern | Use |
|---|---|---|
| `rake test` / `rake test:all` | `test/**/*_test.rb` | Full suite |
| `rake test:unit` | `test/unit/**/*_test.rb` | Unit tests |
| `rake test:critical` | `test/system/*_test.rb` | Fast required gate after every micro-change (<10 lines) |
| `rake test:integration` | `test/integration/**/*_test.rb` | Integration tests |
| `rake build` | — | Runs `bin/hugo-build` |
| `rake dev` | — | Runs `bin/hugo-dev` |
| `rake lighthouse[limit]` | — | Runs `bin/lighthouse` across crawled pages |

Default rake task is `test:all`.

# Visual regression gate (mandatory for CSS/HTML/template changes)

After ANY edit to `themes/`, `layouts/`, blog post body HTML, or
`*.css`, run BOTH `bin/test` (macOS host) and `bin/dtest`
(Linux/Docker) before committing — they write to separate baseline
directories (`test/fixtures/screenshots/macos/` vs `linux/`) and CI
runs Linux, so `bin/test` alone can pass locally while shipping a
broken Linux build. Tolerance: 0.0 for refactors (zero visual
difference), ≤0.03 for genuinely new features. Failures are commit
blockers, not warnings — either fix the regression or confirm intent
and update both baseline directories in the same commit.

Test quality rule: assertions must be behavior-focused, not
config/existence checks. Don't hardcode tunable values (`q=90`, `w=360`,
exact byte sizes) — assert shape (`q=\d+`, presence of `<picture>`,
`src` contains `wsrv.nl`) instead.

# Citations

[1] `Rakefile`
[2] `test/test_helper.rb`
