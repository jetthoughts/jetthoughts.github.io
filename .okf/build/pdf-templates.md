---
type: Build Pipeline
title: Course template PDFs
description: bin/generate-template-pdfs regenerates the downloadable course PDFs from built pages; run it after editing any template chapter.
resource: bin/generate-template-pdfs
tags: [build, pdf, course]
timestamp: 2026-07-13T00:00:00Z
---

The course offers downloadable PDF versions of its template chapters
(worksheet, ownership checklist, and siblings). They are generated FROM the
built HTML pages, so any content change to a template chapter silently
stales its PDF.

# Steps

1. Edit the template chapter markdown.
2. `bin/hugo-build`
3. `bin/generate-template-pdfs`
4. Commit the regenerated PDFs together with the content change.
