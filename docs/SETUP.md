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
  `.dev/compose.yml` image tag). Keep every copy in sync with `.mise.toml`
  when bumping a version.
- Do NOT install hugo/bun via Homebrew: brew's floating versions drift from
  CI. The Brewfile intentionally carries only system libraries.

## System dependencies

| Dependency | Why | macOS | Debian/Ubuntu |
|---|---|---|---|
| libvips | screenshot-diff tests (`gem "vips"`) | `brew install vips` | `apt-get install libvips42` |
| Chrome (pinned) | Capybara system tests | Chrome.app | `bin/setup-test-env` (pinned Chrome for Testing + fonts) |
| lychee | link checks (`rake test:links`) | `brew install lychee` | [releases](https://github.com/lycheeverse/lychee/releases) |

On Linux, don't use a random distro Chromium for visual tests — install the
pinned rendering stack instead:

```bash
bin/setup-test-env                       # Chrome for Testing + chromedriver
                                         # (version: .dev/cft-version) + Noto
                                         # fonts + .dev/fonts.conf
eval "$(bin/setup-test-env --print-env)" # exports CHROME_BIN/CHROMEDRIVER_PATH
```

For any other custom Chrome location, `CHROME_BIN=/path/to/chrome` (and
optionally `CHROMEDRIVER_PATH`) point the tests at it.

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

## Agent containers / remote sessions

Remote agent sessions (Claude web, sandboxes) bootstrap automatically: the
checked-in `.claude/settings.json` runs **`bin/agent-bootstrap`** on session
start (log: `/tmp/agent-bootstrap.log`). It is idempotent and safe to re-run
by hand. Container constraints it works around:

- `api.github.com` is blocked through the agent proxy, so `mise install`
  cannot fetch hugo/bun there. Test code stays Ruby >= 3.3 compatible so the
  suite runs on the container's Ruby even without the 4.0.6 pin.
- `storage.googleapis.com` IS reachable, so the pinned Chrome for Testing
  stack installs normally via `bin/setup-test-env`.
- Set a UTF-8 locale (`LANG=C.UTF-8`) — the bootstrap exports one if unset.

## Pre-push guard

`bin/setup` wires `git config core.hooksPath .githooks`. The `pre-push` hook
runs the fast CI mirrors (CSS lint ratchet, course validators, toolchain-pin
and bin-script guard tests, <10s warm) so a failing push dies locally instead
of in CI. Bypass once, intentionally: `SKIP_CHECKS=1 git push`.

## Visual regression baselines

Screenshot baselines live in `test/fixtures/screenshots/{macos,linux}/` and
are **rewritten in place by every test run** (working tree = candidate,
git HEAD = baseline). After a run, restore them unless you intend to update
them: `bin/rake test:screenshots:reset` (a guard refuses to start system
tests on dirty baselines; bypass intentionally with
`ALLOW_DIRTY_SCREENSHOTS=1`). Baselines are only comparable on the rendering
stack that recorded them — macOS captures on a Mac; `linux/` captures on the
pinned glibc stack (Chrome for Testing `.dev/cft-version` + `.dev/fonts.conf`
+ Noto fonts), which both the `bin/dtest` Docker image and
`bin/setup-test-env` provide. A bare-metal Linux run through
`bin/setup-test-env` IS comparable to `linux/` baselines — unpinned distro
Chromium is not.
