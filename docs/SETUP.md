# Development Environment Setup

One command does it all:

```bash
bin/setup
```

It installs the pinned toolchain, system libraries, and project dependencies,
then runs a doctor that verifies each piece and prints a fix for anything
missing. The rest of this page explains what it sets up and how to do each
piece manually.

## Toolchain (mise)

Hugo Extended, Bun, Node, and Ruby versions are pinned in **`.mise.toml`** —
the single source of truth. Install [mise](https://mise.jdx.dev) once, then:

```bash
mise install    # reads .mise.toml, installs exact pinned versions
```

- The Ruby pin is mirrored in `.ruby-version` (exact patch version — rbenv
  users can `rbenv install $(cat .ruby-version)` instead of mise).
- CI carries its own copies of the pins (composite action
  `.github/actions/setup-hugo/action.yml`, workflow `ruby-version` inputs,
  `.dev/compose.yml` image tag). `test/unit/toolchain_pins_test.rb` fails the
  build when any copy drifts from `.mise.toml` — update them together.
- Do NOT install hugo/bun via Homebrew: brew's floating versions drift from
  CI. The Brewfile intentionally carries only system libraries.

## System dependencies

| Dependency | Why | macOS | Debian/Ubuntu |
|---|---|---|---|
| libvips | screenshot-diff tests (`gem "vips"`) | `brew install vips` | `apt-get install libvips42` |
| Chrome/Chromium | Capybara system tests | Chrome.app | `apt-get install chromium` |
| lychee | link checks (`rake test:links`) | `brew install lychee` | [releases](https://github.com/lycheeverse/lychee/releases) |

If Chrome is not on PATH (CI containers, custom installs), point the tests at
a binary with `CHROME_BIN=/path/to/chrome`.

**Locale**: the course validators and tests read UTF-8 content; use a UTF-8
locale (`LANG=C.UTF-8`) in minimal containers where none is set.

## Project dependencies

```bash
bun install      # JS deps (bun.lockb is the only lockfile - no npm)
bundle install   # Ruby gems (tests, validators, sync)
```

## Daily commands

| Command | What |
|---|---|
| `bin/dev` | Dev server at :1313 (wraps `hugo server` with the PATH/env the PostCSS pipeline needs — bare `hugo server` fails CSS builds) |
| `bin/hugo-build` | Full build + course validators + PurgeCSS warm-up |
| `bin/test` | Critical suite (`bin/rake test:critical`); pass a file path for one file |
| `bin/rake test:unit` | Unit tests (needs a built site: `PRECOMPILED_ASSETS=1 HUGO_DEFAULT_PATH=_dest/public-test`, base URL `http://localhost:1314`) |
| `bin/dtest` | Critical suite inside Linux/Docker — the `linux/` visual baselines are recorded on this image |
| `bin/qtest --changed` | Fast scoped visual gate for CSS work |
| `bin/lint-css` | Stylelint warning ratchet (cap only goes down) |

## Visual regression baselines

Screenshot baselines live in `test/fixtures/screenshots/{macos,linux}/` and
are **rewritten in place by every test run** (working tree = candidate,
git HEAD = baseline). After a run, restore them unless you intend to update
them: `git checkout -- test/fixtures/screenshots/`. Baselines are only
comparable on the rendering stack that recorded them — macOS captures on a
Mac, `linux/` captures inside the `bin/dtest` Docker image. A bare-metal
Linux run against `linux/` baselines produces font-rendering diffs that are
environmental, not regressions.
