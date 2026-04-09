# Bin Directory Scripts

This directory contains utility scripts for the JetThoughts Hugo site.

## Build & Development

- `dev` - Start development server with hot reload (port 1313)
- `debug` - Start development server with debug logging
- `build` - Build production site
- `benchmark-dev` - Benchmark development server performance

## Testing

- `test` - Run Ruby test suite
- `dtest` - Run tests in Docker environment
- `lighthouse` - Run Lighthouse performance benchmarks (90+ score requirement)
- `lighthouse-compare` - Compare two Lighthouse benchmark runs

## Docker

- `dc` - Docker Compose wrapper
- `docked` - Run commands in Docker container

## Utilities

- `setup` - Initial project setup
- `rake` - Ruby task runner
- `bunx` - NPM package runner (using bunx)
- `sync_with_devto` - Sync blog posts with dev.to

## Content

- `generate-cover-image` - Generate a blog post cover image (1200x630 JPEG) via the Gemini CLI. Takes two positional args: `<slug>` and `"concept sentence"`. Writes to `content/blog/<slug>/cover.jpg`. Uses the `gemini-3.1-flash-image-preview` model (Nano Banana 2); requires `GEMINI_API_KEY` from https://aistudio.google.com/app/apikey. Full design system rationale in `docs/projects/2510-seo-content-strategy/20-29-strategy/20.06-blog-cover-image-design-system.md`.

## Deprecated

- `surge` - Static site deployment (folder)
