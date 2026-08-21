---
title: v2 preview
# Clean-slate v2 rail (ADR-0006). Everything under /next/ is staging on the
# production host: never indexed, never listed, never in the sitemap.
# noindex -> layouts/partials/seo/enhanced-meta-tags.html robots meta
# private -> layouts/sitemap.xml skips the page
cascade:
  noindex: true
  private: true
---
