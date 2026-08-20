# Build & Test

* [Hugo build pipeline](hugo-build.md) - bin/hugo-build with the 8 course validators; also the PurgeCSS cold-start race and the minified-unquoted-attribute audit-tool trap
* [Test gates](test-gates.md) - the local suites, when each is a commit blocker, and bin/record-baselines for accepting only the baselines you meant to move
* [CI gates](ci-gates.md) - what GitHub Actions enforces: build, unit, path-scoped link check (visual regression is report-only), and what gates a PR never sees
* [Template PDFs](pdf-templates.md) - regenerating the downloadable course PDFs
