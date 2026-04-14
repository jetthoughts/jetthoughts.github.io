# CDN Image Proxy for Production

Solves the GitHub Pages 1 GB artifact limit by serving blog images from a CDN proxy in production, while keeping local Hugo image processing for development.

## How It Works

1. **Development** (`hugo server`): Images processed locally by Hugo as before — no change.
2. **Production** (`--environment production`): Templates emit CDN URLs instead of local paths. Hugo still reads images for dimensions but skips processing.
3. **GitHub Actions**: After Hugo build, all blog media files are deleted from `public/blog/` before uploading the artifact.

## Configuration

**Default** (`config/_default/hugo.toml`) — CDN disabled:
```toml
[params.cdn]
  enabled = false
  provider = "wsrv"
  rawBase = "raw.githubusercontent.com/jetthoughts/jetthoughts.github.io/master/content/"
```

**Production** (`config/production/hugo.toml`) — CDN enabled:
```toml
[params.cdn]
  enabled = true
```

Gate in templates: `{{ if site.Params.cdn.enabled }}`

**Important:** Root `layouts/` overrides `themes/beaver/layouts/`. Both copies of `enhanced-meta-tags.html` must be updated.

## Templates Modified

| Template | CDN behavior |
|----------|-------------|
| `_markup/render-image.html` | `<picture>` srcset via wsrv.nl (webp+jpeg, 400/800/1200/1600w) |
| `partials/blog/img-cropped.html` | Retina thumbnail via wsrv.nl |
| `partials/seo/enhanced-meta-tags.html` | OG image (1200×630) via wsrv.nl |
| `_shortcodes/img.html` | Direct image via wsrv.nl |

## Solution 1: wsrv.nl (Current)

Free image proxy at [wsrv.nl](https://wsrv.nl). No account needed. Supports resizing, format conversion, quality control.

**URL pattern:**
```
https://wsrv.nl/?url=raw.githubusercontent.com/OWNER/REPO/BRANCH/content/PATH&w=WIDTH&output=FORMAT&q=QUALITY
```

**Params used:**
- `&w=N` — width resize
- `&h=N` — height resize
- `&output=webp|jpeg` — format conversion
- `&q=N` — quality (80 default, 85 OG, 90 thumbnails)
- `&fit=inside` — aspect-preserving fit (OG images)

**Pros:** Zero cost, zero setup, good caching.
**Cons:** Third-party dependency, no SLA, images must be in a public repo.

## Solution 2: Cloudflare R2 (Future)

Upload all image variants to Cloudflare R2 bucket with a custom domain (e.g., `cdn.jetthoughts.com`).

### Setup Required

1. Create R2 bucket + connect custom domain
2. Add GitHub secrets: `R2_ACCESS_KEY_ID`, `R2_SECRET_ACCESS_KEY`, `R2_ENDPOINT_URL`, `R2_BUCKET_NAME`
3. Change config:
   ```toml
   [params.cdn]
     enabled = true
     provider = "cloudflare"
     cloudflareBase = "cdn.jetthoughts.com"
   ```
4. Update templates to check `provider` and use `cloudflareBase` for URL prefix
5. Add sync step to GitHub Actions before media cleanup:
   ```yaml
   - name: Sync media to Cloudflare R2
     env:
       AWS_ACCESS_KEY_ID: ${{ secrets.R2_ACCESS_KEY_ID }}
       AWS_SECRET_ACCESS_KEY: ${{ secrets.R2_SECRET_ACCESS_KEY }}
       AWS_DEFAULT_REGION: auto
       ENDPOINT_URL: ${{ secrets.R2_ENDPOINT_URL }}
     run: |
       aws s3 sync ./public/ s3://${{ secrets.R2_BUCKET_NAME }}/ \
         --endpoint-url $ENDPOINT_URL \
         --exclude "*" \
         --include "*.jpg" --include "*.jpeg" --include "*.png" \
         --include "*.gif" --include "*.webp" --include "*.mp4"
   ```

**Pros:** Full control, SLA, works with private repos, custom domain.
**Cons:** Requires R2 account, AWS CLI in CI, storage costs (minimal).

## Not Yet Covered

These templates still use local Hugo processing (non-blog assets from `assets/`/`static/`, not affected by blog media cleanup):

- `partials/img/generic.html` (hero, homepage, testimonials, etc.)
- `partials/img/resize.html`
- `partials/page/cover_image.html`
