# CSS Consolidation Rules

- Never modify vendor files (`css/vendors/*.min.css`) or dynamic templates (`css/dynamic-*.css`)
- Preserve cascade order: Critical → Layout → Component → Theme → Footer
- Extract whole rule sets; keep page-specific `.fl-node-{hash}` selectors in original files
- Run `bin/rake test:critical` after each extraction

Reference: `docs/projects/2509-css-migration/css-loading-order-analysis.md`
