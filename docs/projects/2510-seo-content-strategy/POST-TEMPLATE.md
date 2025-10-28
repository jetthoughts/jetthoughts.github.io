# JetThoughts Blog Post Templates Reference

**Last Updated**: 2025-10-17
**Purpose**: Standardized frontmatter templates for blog post creation
**Authority**: Based on analysis of existing published posts (2024-2025)

---

## Template Selection Guide

Use this decision tree to choose the correct template:

```
Is this post imported from dev.to?
├─ YES → Use Template A (Dev.to Imported Post)
└─ NO → Is this a comprehensive tutorial/guide?
    ├─ YES → Use Template B (Comprehensive Tutorial)
    └─ NO → Use Template C (Simple Native Post)
```

---

## Template A: Dev.to Imported Post

**When to use**: Posts published first on dev.to, then synced to JetThoughts blog
**Required fields**: ALL fields listed below
**Examples**: Most blog posts from 2024-2025 (80%+ of content)

```yaml
---
remote_url: https://dev.to/jetthoughts/article-slug-xxxxx
source: dev_to
remote_id: 1234567
dev_to_id: 1234567
dev_to_url: https://dev.to/jetthoughts/article-slug-xxxxx
title: 'Article Title Here'
description: Article description here. Should be under 160 characters for SEO.
created_at: '2025-10-17T10:00:00Z'
edited_at: '2025-10-17T10:00:00Z'
draft: false
tags:
- tag1
- tag2
- tag3
canonical_url: https://jetthoughts.com/blog/article-slug/
cover_image: https://raw.githubusercontent.com/jetthoughts/jetthoughts.github.io/master/content/blog/article-slug/cover.jpeg
date: "2025-10-17"
metatags:
  image: cover.jpeg
slug: article-slug
---
```

### Field Specifications

| Field | Format | Required | Notes |
|-------|--------|----------|-------|
| `remote_url` | Full dev.to URL | ✅ | Dev.to article URL |
| `source` | `dev_to` | ✅ | Always "dev_to" |
| `remote_id` | Integer | ✅ | Dev.to article ID |
| `dev_to_id` | Integer | ✅ | Same as remote_id |
| `dev_to_url` | Full dev.to URL | ✅ | Same as remote_url |
| `title` | String (60 chars max) | ✅ | Can use single quotes or no quotes |
| `description` | String (155-160 chars) | ✅ | SEO meta description |
| `created_at` | ISO 8601 with timezone | ✅ | Single quotes: `'2025-10-17T10:00:00Z'` |
| `edited_at` | ISO 8601 with timezone | ✅ | Single quotes: `'2025-10-17T10:00:00Z'` |
| `draft` | Boolean | ✅ | `false` for published posts |
| `tags` | Array | ✅ | Can be empty `[]` |
| `canonical_url` | Full JetThoughts URL | ✅ | Official post URL |
| `cover_image` | Full GitHub raw URL | ✅ | Must be actual image file in repo |
| `date` | YYYY-MM-DD | ✅ | Can have quotes or not: `"2025-10-17"` OR `2025-10-17` |
| `metatags.image` | Relative filename | ✅ | Same as cover image filename: `cover.jpeg` |
| `slug` | String | ✅ | URL-friendly slug |

### Critical Rules

1. **Date formats**:
   - `created_at`/`edited_at`: MUST use single quotes with timezone (`'2025-10-17T10:00:00Z'`)
   - `date`: Can use double quotes OR no quotes (`"2025-10-17"` OR `2025-10-17`)

2. **Image references**:
   - `cover_image`: MUST be full GitHub raw URL
   - `metatags.image`: MUST be relative filename only
   - Both MUST reference actual existing image files

3. **Dev.to fields**:
   - `remote_id` and `dev_to_id` MUST be identical
   - `remote_url` and `dev_to_url` MUST be identical

---

## Template B: Comprehensive Tutorial (AI-Generated Content)

**When to use**: Long-form tutorials, comprehensive guides, AI-generated content
**Required fields**: ALL fields listed below
**Examples**: Python LangChain tutorial, Laravel AI integration, Elixir AI tutorial, Django migration guides

```yaml
---
title: "Tutorial Title: Complete Guide 2025"
description: "Learn [topic] with this comprehensive tutorial. Step-by-step guide with [framework] integration, production patterns, and 15+ working code examples. Build your first [thing] today."
date: 2025-10-27
draft: false
tags: ["tag1", "tag2", "tag3", "tag4"]
canonical_url: "https://jetthoughts.com/blog/tutorial-slug/"
slug: "tutorial-slug"
---
```

### Field Specifications

| Field | Format | Required | Notes |
|-------|--------|----------|-------|
| `title` | String (55-60 chars) | ✅ | Include year: "2025" |
| `description` | String (155-160 chars) | ✅ | SEO meta description with benefit |
| `date` | YYYY-MM-DD | ✅ | No quotes, no timezone: `2025-10-27` |
| `draft` | Boolean | ✅ | `false` for published posts |
| `tags` | Array of strings | ✅ | 4-7 relevant tags |
| `canonical_url` | Full JetThoughts URL | ✅ | Official post URL with trailing slash |
| `slug` | String | ✅ | URL-friendly slug |

### Critical Rules

1. **Date formats**:
   - `date`: Simple YYYY-MM-DD format, NO quotes, NO timezone
   - NO `created_at` or `edited_at` fields

2. **NO metatags**:
   - Do NOT include `metatags.image` unless actual OG image exists
   - Better to omit than reference non-existent file

3. **Title optimization**:
   - Keep under 60 characters for Google SERPs
   - Include year (2025) for freshness signal
   - Format: "[Topic] [Type]: Complete Guide [Year]"

4. **Description optimization**:
   - 155-160 characters (Google's display limit)
   - Include primary keyword
   - Include benefit/outcome
   - Include number of examples if applicable

---

## Template C: Simple Native Post

**When to use**: Quick blog posts, announcements, simple articles
**Required fields**: Minimal set
**Examples**: RAG applications guide, simple tutorials

```yaml
---
title: "Article Title Here"
description: "Brief description of the article content. Keep under 160 characters."
date: 2025-10-17
tags: ["tag1", "tag2", "tag3"]
author: "JetThoughts Team"
slug: "article-slug"
---
```

### Field Specifications

| Field | Format | Required | Notes |
|-------|--------|----------|-------|
| `title` | String (60 chars max) | ✅ | SEO title |
| `description` | String (155-160 chars) | ✅ | SEO meta description |
| `date` | YYYY-MM-DD | ✅ | No quotes, no timezone |
| `tags` | Array of strings | ✅ | 3-6 relevant tags |
| `author` | String | ✅ | Usually "JetThoughts Team" |
| `slug` | String | ✅ | URL-friendly slug |

### Critical Rules

1. **Minimal format**:
   - NO created_at/edited_at (just date)
   - NO canonical_url
   - NO metatags
   - NO cover_image

2. **Date format**:
   - Simple YYYY-MM-DD format
   - NO quotes, NO timezone

---

## SEO Requirements (ALL Templates)

### Meta Description Guidelines

**Character limits**:
- Minimum: 155 characters
- Maximum: 160 characters
- Ideal: 158-159 characters

**Structure**:
```
[Primary keyword action] with [framework/tool]. [Benefit]. [Number] [type of content]. [Call to action].
```

**Example**:
```
Learn Laravel AI integration with OpenAI PHP in 2025. Complete tutorial with queue jobs, testing, and 15+ production code examples. Build AI-powered Laravel apps.
```

### Title Tag Guidelines

**Character limits**:
- Maximum: 60 characters (Google truncates at ~60)
- Ideal: 55-58 characters

**Structure**:
```
[Primary keyword]: [Type] [Year] | [Brand]
```

**Example**:
```
Ruby LangChain Testing Guide 2025 | RSpec + WebMock
```

### FAQ Section (MANDATORY for AI content)

ALL comprehensive tutorials MUST include FAQ section for featured snippet optimization:

```markdown
## Frequently Asked Questions {#faq}

**Q: [Question including primary keyword]?**

A: [Answer with keyword density, 50-100 words]

**Q: [Question about common pain point]?**

A: [Solution-focused answer]

[Repeat for 5 questions total]
```

---

## Content Agent Instructions

### For Creating New Posts

1. **Choose template** based on decision tree above
2. **Fill required fields** according to template specifications
3. **Optimize meta description**:
   - 158-159 characters
   - Include primary keyword
   - Include benefit
4. **Optimize title**:
   - Under 60 characters
   - Include year (2025)
   - Include primary keyword
5. **Add FAQ section** (for tutorials):
   - 5 questions minimum
   - Focus on "how to" and "what is" queries
   - Include primary keyword in 2-3 questions
6. **Date handling**:
   - Template A: Single quotes with timezone
   - Template B: Double quotes with timezone
   - Template C: No quotes, no timezone
7. **Image verification**:
   - ONLY include metatags.image if file EXISTS
   - Check file existence before adding image references
   - Better to omit than reference non-existent file

### Pre-Publication Checklist

- [ ] Template matches post type (dev.to vs native vs tutorial)
- [ ] All required fields present
- [ ] Meta description 155-160 characters
- [ ] Title under 60 characters
- [ ] Date format matches template specifications
- [ ] Tags array has 3-7 relevant tags
- [ ] Slug is URL-friendly (lowercase, hyphens)
- [ ] FAQ section present (for comprehensive tutorials)
- [ ] Image references validated (files exist)
- [ ] Hugo build test passes: `hugo --quiet`

---

## Common Mistakes to Avoid

### ❌ Wrong Date Formats

```yaml
# WRONG for Template A (dev.to):
created_at: "2025-10-17T10:00:00Z"  # Double quotes

# CORRECT:
created_at: '2025-10-17T10:00:00Z'  # Single quotes
```

### ❌ Invalid Image References

```yaml
# WRONG (image doesn't exist):
metatags:
  image: og-ruby-langchain-testing.png

# CORRECT (omit if image doesn't exist):
# (no metatags section)
```

### ❌ Missing Required Fields

```yaml
# WRONG for Template A (dev.to):
---
title: "Article Title"
description: "Description"
tags: ["ruby", "rails"]
slug: "article-slug"
---

# CORRECT (includes ALL required dev.to fields):
---
remote_url: https://dev.to/...
source: dev_to
remote_id: 1234567
dev_to_id: 1234567
dev_to_url: https://dev.to/...
title: "Article Title"
description: "Description"
created_at: '2025-10-17T10:00:00Z'
edited_at: '2025-10-17T10:00:00Z'
draft: false
tags: ["ruby", "rails"]
canonical_url: https://jetthoughts.com/blog/article-slug/
cover_image: https://raw.githubusercontent.com/.../cover.jpeg
date: "2025-10-17"
metatags:
  image: cover.jpeg
slug: article-slug
---
```

### ❌ Meta Description Too Long

```yaml
# WRONG (225 characters):
description: "Learn Laravel AI integration with OpenAI PHP package. Step-by-step guide with queue jobs, Eloquent ORM integration, PHPUnit testing, and 15+ production-ready code examples. Build your first AI-powered Laravel app today."

# CORRECT (159 characters):
description: "Learn Laravel AI integration with OpenAI PHP in 2025. Complete tutorial with queue jobs, testing, and 15+ production code examples. Build AI-powered Laravel apps."
```

---

## Template Evolution Notes

**2025-10-17**: Initial documentation based on analysis of:
- 5 dev.to imported posts (Template A pattern)
- 2 native tutorial posts (Template B pattern)
- 1 simple native post (Template C pattern)

**Key learnings**:
- Dev.to posts use single quotes for timestamps, native tutorials use double quotes
- All posts MUST have date field (dev.to) OR created_at field (native)
- Image references cause Hugo build issues if files don't exist
- FAQ sections significantly improve featured snippet probability

---

## Questions or Updates?

**Contact**: JetThoughts content team
**Documentation**: `/docs/projects/2510-seo-content-strategy/`
**Examples**: `/content/blog/` (analyze existing published posts)
