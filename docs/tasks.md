# Landing Page Simplification Tasks

Goal: simplify homepage layout/CSS architecture while preserving behavior and visual output.

## Task 1: Remove Hard-Coded Global Body Classes

Priority: High  
Risk: Low  
Files:
- `themes/beaver/layouts/baseof.html`

Problem:
- `baseof.html` currently hard-codes page-specific body classes globally.
- This leaks homepage identity/styles into other pages and increases maintenance risk.

Implementation:
1. Replace fixed body class string with Hugo-derived page/template/kind classes.
2. Keep required stable framework classes (`fl-*`) used by existing CSS.
3. Do not change homepage template markup in this task.

Validation:
```bash
bin/test test/unit/baseof_template_test.rb
bin/test test/unit/home_template_test.rb
bin/dtest test/system/desktop_site_test.rb
```

Non-Docker visual alternative:
```bash
hugo --noBuildLock --buildDrafts --environment production --destination=_dest/public-dtest --baseURL="http://localhost:1314"
PRECOMPILED_ASSETS=true HUGO_DEFAULT_PATH=_dest/public-dtest TEST_SERVER_PORT=1314 bundle exec rake test:critical
```

---

## Task 2: Reduce Homepage CSS Bundle Coupling

Priority: High  
Risk: Medium  
Files:
- `themes/beaver/layouts/home.html`
- `themes/beaver/assets/css/*` (selected files only)

Problem:
- Homepage bundle currently includes legacy and mixed-purpose styles.
- This increases side effects and makes refactoring costly.

Implementation:
1. Define explicit homepage bundle composition in `home.html`.
2. Remove/relocate one questionable stylesheet at a time (small PR increments).
3. Keep output CSS fingerprinting pipeline unchanged.

Validation:
```bash
bin/test test/unit/home_template_test.rb
bin/test test/unit/hugo_asset_validation_test.rb
bin/dtest test/system/desktop_site_test.rb test/system/mobile_site_test.rb
```

Rollback rule:
- If any visual diff or layout regression appears, revert the last removed stylesheet and split smaller.

---

## Task 3: Add Stable Semantic Hooks (Without Removing Existing `fl-node-*`)

Priority: Medium  
Risk: Medium  
Files:
- `themes/beaver/layouts/home.html`
- `themes/beaver/assets/css/homepage.css`
- `themes/beaver/assets/css/homepage-sections.css` (new)

Problem:
- Homepage markup/styles are tightly coupled to generated `fl-node-*` classes.
- Small content/editor changes can break selectors.

Implementation:
1. Add semantic wrapper classes per section (`jt-home-hero`, `jt-home-proof`, etc.).
2. Keep all existing `fl-*` classes intact for compatibility.
3. Add mirrored styles to `homepage-sections.css`, loaded last.
4. Migrate section by section in follow-up tasks.

Validation:
```bash
bin/test test/unit/home_template_test.rb
bin/dtest test/system/desktop_site_test.rb test/system/mobile_site_test.rb
```

Acceptance:
- No visual regressions in screenshot tests.
- No change in CTA links, headings, or section ordering.

---

## Visual Regression Execution Notes

Docker path (recommended baseline):
```bash
bin/dtest
```

Targeted Docker run:
```bash
bin/dtest test/system/desktop_site_test.rb
```

Non-Docker path:
```bash
hugo --noBuildLock --buildDrafts --environment production --destination=_dest/public-dtest --baseURL="http://localhost:1314"
PRECOMPILED_ASSETS=true HUGO_DEFAULT_PATH=_dest/public-dtest TEST_SERVER_PORT=1314 bundle exec rake test:critical
```
