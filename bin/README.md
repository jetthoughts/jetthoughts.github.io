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

- `generate-cover-image` - Generate a blog post cover image (1200x630 JPEG) via the Gemini CLI. Takes a prompt as argument or stdin; writes to `content/blog/<slug>/cover.jpg` with `--slug`, or to an explicit path with `--out`. Supports `--dry-run` to preview the invocation without burning API quota. Requires `gemini` CLI with an image-generation tool (Imagen, Stitch, or an image-gen MCP). Run `bin/generate-cover-image --help` for full usage.

## Deprecated

- `surge` - Static site deployment (folder)
