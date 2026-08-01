# Bin Directory Scripts

Utility scripts for the JetThoughts Hugo site. This list matches the actual
contents of `bin/` — if you add or remove a script, update it here.

## Build & Development

- `dev` - Development server with hot reload (port 1313, development PostCSS chain)
- `build` - Production build (wraps `hugo-build`)
- `hugo-build` - Canonical production build: PurgeCSS cold-start warm-up guard, validation. ALL production builds route through this
- `build-if-stale <dest> [base-url]` - Shared helper: builds via `hugo-build` only when sources are newer than the dest tree (`FORCE_BUILD=1` overrides). Used by `test`/`qtest`/`dtest`/`dtest-all`
- `hugo-clean` - Remove build artifacts (`_dest`, caches)

## Testing

- `qtest [--changed|--all|page-keys]` - Fast scoped visual gate (~25-90s): only the screenshot tests for pages a change touches, plus random extras. The per-micro-commit gate
- `test [--smoke|file.rb]` - Local suite against a warm prebuilt tree: `rake test:critical` by default, the ~50s smoke tier with `--smoke`, or a single test file
- `dtest [--smoke|file.rb]` - Same as `test` but inside the Docker rendering container (Linux baselines); args pass through
- `dtest-all` - Whole suite (`rake test:all`) in Docker, detached; logs to `tmp/dtest-all.log`
- `setup-test-env` - Install the pinned rendering stack (Chrome for Testing per `.dev/cft-version`, fonts, fontconfig); prints `CHROME_BIN`/`CHROMEDRIVER_PATH` with `--print-env`
- `lighthouse` / `lighthouse-compare` - Performance benchmarks and run comparison
- `lint-css` - Stylelint ratchet (warning count can only go down)
- `validate-course` - Course content validators

## Docker

- `dc` - Docker Compose wrapper
- `docked` - Run a command in the test container
- `docker-rebuild` - Nuke and rebuild the compose images from scratch

## Setup

- `setup` - Initial project setup (mise, bundle, hooks via `core.hooksPath .githooks`, doctor summary)
- `agent-bootstrap` - Idempotent agent/remote-session bootstrap (bundle, bun, test env); wired as a SessionStart hook

## Content & Sync

- `sync_with_devto` - Sync blog posts with dev.to
- `skillshare-sync` - Sync skills to configured AI CLI targets
- `generate-template-pdfs` - Regenerate course template PDFs

## CSS Migration Tooling (project 2509)

- `css-split` - Extract shared-component rules from a page CSS file
- `css-winners` - Compare two compiled bundles at the per-selector winner level

## Misc

- `rake` - Ruby task runner wrapper
- `hive` - Spawn a claude-flow hive-mind session
- `surge/` - Static preview deployment (folder: `deploy`, `cleanup`)
