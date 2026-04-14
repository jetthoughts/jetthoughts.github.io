# CDN Image Proxy for Production

Solves the GitHub Pages 1 GB artifact limit by serving blog images from a CDN proxy in production, while keeping local Hugo image processing for development.

## How It Works

1. **Development** (`hugo server`): Images processed locally by Hugo — no change.
2. **Production** (`--environment production`): Templates emit CDN URLs instead of local paths via `partials/cdn/url.html`.
3. **GitHub Actions**: After Hugo build, blog media files are deleted from `public/blog/` before uploading the artifact.

## Configuration

**Default** (`config/_default/hugo.toml`) — CDN disabled:
```toml
[params.cdn]
  enabled = false
  rawBase = "raw.githubusercontent.com/jetthoughts/jetthoughts.github.io/master/content/"
```

**Production** (`config/production/hugo.toml`) — CDN enabled:
```toml
[params.cdn]
  enabled = true
```

Gate in templates: `{{ if site.Params.cdn.enabled }}`

## Shared Partial

`themes/beaver/layouts/partials/cdn/url.html` — single source for CDN URL construction:

```text
{{ partial "cdn/url" (dict "page" $page "resource" $resource "params" "w=400&output=webp&q=80") }}
→ "https://wsrv.nl/?url=raw.githubusercontent.com/.../image.jpg&w=400&output=webp&q=80"
```

## Templates Modified

| Template | CDN behavior |
|----------|-------------|
| `_markup/render-image.html` | `<picture>` srcset via wsrv.nl (webp+jpeg, 400/800/1200/1600w) |
| `partials/blog/img-cropped.html` | Retina thumbnail via wsrv.nl |
| `partials/seo/enhanced-meta-tags.html` | OG image (1200×630) via wsrv.nl |
| `_shortcodes/img.html` | Direct image via wsrv.nl |

**Note:** Root `layouts/` overrides `themes/beaver/layouts/`. Both `enhanced-meta-tags.html` copies must stay in sync.

## wsrv.nl Params

- `&w=N` — width resize
- `&h=N` — height resize
- `&output=webp|jpeg` — format conversion
- `&q=N` — quality (80 content, 85 OG, 90 thumbnails)
- `&fit=cover` — crop to exact dimensions (OG images)

## Not Yet Covered

Non-blog image templates (assets from `assets/`/`static/`, unaffected by blog media cleanup):

- `partials/img/generic.html` (hero, homepage, testimonials)
- `partials/img/resize.html`
- `partials/page/cover_image.html`
