# Build & Test

* [Hugo build pipeline](hugo-build.md) - bin/hugo-build with the 8 course validators; also the PurgeCSS cold-start race and the minified-unquoted-attribute audit-tool trap
* [Test gates](test-gates.md) - the local suites, when each is a commit blocker, bin/record-baselines for accepting only the baselines you meant to move, and why a deleted source file still serves from every local _dest/ tree, plus the NULL CHANGE - a diff that passes every gate and alters nothing - and what `okf_validate` actually guards (shape, not truth; error-only conformance) with the two-spec trap
* [CI gates](ci-gates.md) - what GitHub Actions enforces: build, unit, path-scoped link check (visual regression is report-only), and what gates a PR never sees
* [Template PDFs](pdf-templates.md) - regenerating the downloadable course PDFs
