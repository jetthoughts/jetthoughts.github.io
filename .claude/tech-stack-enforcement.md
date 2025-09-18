# Tech Stack Enforcement Configuration - jt_site

## 🎯 PROJECT TECH STACK PROFILE

**Language**: Go (Hugo)
**Framework**: Hugo 0.150+ (Static Site Generator)
**Testing**: Ruby-based system tests (Minitest + Capybara)
**Frontend**: HTML/CSS/JavaScript (ESBuild + PostCSS + Tailwind)
**Package Manager**: Bun (with npm compatibility)
**Deployment**: GitHub Pages / Static hosting
**Architecture**: Hugo static site with Go templates and asset processing

## ✅ MANDATORY PATTERNS (Hugo/Go Templates)

### Hugo Template Patterns (REQUIRED)
```go-html-template
<!-- ✅ CORRECT: Hugo template syntax -->
{{ range .Site.RegularPages }}
  <article>
    <h2>{{ .Title }}</h2>
    <time>{{ .Date.Format "January 2, 2006" }}</time>
    {{ .Summary }}
  </article>
{{ end }}

<!-- ✅ CORRECT: Hugo partials -->
{{ partial "header.html" . }}
{{ partial "navigation.html" . }}

<!-- ✅ CORRECT: Hugo layouts -->
{{ define "main" }}
  <main>
    {{ .Content }}
  </main>
{{ end }}

<!-- ✅ CORRECT: Hugo functions -->
{{ .Content | markdownify }}
{{ .Date | time.Format ":date_long" }}
{{ where .Site.RegularPages "Section" "blog" }}
```

### Hugo Configuration (REQUIRED)
```toml
# config/_default/hugo.toml
baseURL = "https://jetthoughts.com/"
languageCode = "en-us"
title = "JetThoughts"
theme = "beaver"

[markup.goldmark.renderer]
  unsafe = true

[markup.highlight]
  codeFences = true
  lineNos = false
  style = "github"

[permalinks]
  pages = "/:slug/"
  blog = "/blog/:slug/"

[taxonomies]
  tag = "tags"

[params]
  email = "info@jetthoughts.com"
  phone = "+1 754 216 9568"
  description = "JetThoughts's expert team of developers and consultants"
  googleAnalytics = "G-T1N27FC30F"

[[menu.main]]
  identifier = "services"
  name = "Services"
  pageRef = "pages/services/"
  weight = 10

[[menu.main]]
  identifier = "blog"
  name = "Blog"
  pageRef = "blog/"
  weight = 25
```

### Hugo Shortcode Patterns (REQUIRED)
```go-html-template
<!-- layouts/shortcodes/figure.html -->
<figure{{ with .Get "class" }} class="{{ . }}"{{ end }}>
  <img src="{{ .Get "src" }}" alt="{{ .Get "alt" }}">
  {{ with .Get "caption" }}
    <figcaption>{{ . | markdownify }}</figcaption>
  {{ end }}
</figure>

<!-- layouts/shortcodes/youtube.html -->
<div class="video-container">
  <iframe
    src="https://www.youtube.com/embed/{{ .Get 0 }}"
    frameborder="0"
    allowfullscreen>
  </iframe>
</div>

<!-- Usage in content -->
{{< figure src="/images/example.jpg" alt="Description" caption="Figure caption" >}}
{{< youtube "dQw4w9WgXcQ" >}}
```

### Hugo Data Files (REQUIRED)
```yaml
# data/authors.yml
john_doe:
  name: "John Doe"
  email: "john@jetthoughts.com"
  bio: "Ruby developer with 10 years experience"
  avatar: "/images/john.jpg"
  social:
    twitter: "johndoe"
    github: "johndoe"

# data/services.yml
fractional_cto:
  title: "Fractional CTO"
  description: "On-demand technical leadership"
  icon: "cto-icon.svg"
  features:
    - "Technical strategy"
    - "Team building"
    - "Architecture guidance"
```

### Hugo Asset Processing (REQUIRED)
```go-html-template
<!-- layouts/partials/head.html -->
{{ $sass := resources.Get "scss/main.scss" }}
{{ $style := $sass | resources.ToCSS | resources.Minify | resources.Fingerprint }}
<link rel="stylesheet" href="{{ $style.RelPermalink }}">

{{ $js := resources.Get "js/main.js" }}
{{ $script := $js | resources.Minify | resources.Fingerprint }}
<script src="{{ $script.RelPermalink }}"></script>

<!-- Image processing -->
{{ $image := resources.Get "images/hero.jpg" }}
{{ $resized := $image.Resize "800x600" }}
<img src="{{ $resized.RelPermalink }}" alt="Hero image">
```

## ❌ FORBIDDEN PATTERNS (Anti-Hugo)

### Wrong Template Engines (FORBIDDEN)
```erb
<!-- ❌ FORBIDDEN: Liquid syntax (Jekyll) -->
{% for post in site.posts %}     <!-- Wrong -->
{{ range .Site.RegularPages }}   <!-- Correct -->

<!-- ❌ FORBIDDEN: ERB syntax -->
<%= @post.title %>               <!-- Wrong -->
{{ .Title }}                     <!-- Correct -->

<!-- ❌ FORBIDDEN: Handlebars -->
{{#each posts}}                  <!-- Wrong -->
{{ range .Site.RegularPages }}   <!-- Correct -->

<!-- ❌ FORBIDDEN: Jinja2 syntax -->
{% if posts %}                   <!-- Wrong -->
{{ if .Site.RegularPages }}      <!-- Correct -->
```

### Wrong Static Site Generators (FORBIDDEN)
```javascript
// ❌ FORBIDDEN: Jekyll syntax
{% include header.html %}        // Wrong
{{ partial "header.html" . }}   // Correct

// ❌ FORBIDDEN: Gatsby/Next.js
import { graphql } from 'gatsby'         // Wrong
export async function getStaticProps() {} // Wrong

// ❌ FORBIDDEN: 11ty syntax
module.exports = function(eleventyConfig) {} // Wrong
```

### Wrong Configuration (FORBIDDEN)
```yaml
# ❌ FORBIDDEN: Jekyll _config.yml
title: My Site                   # Wrong
plugins:                         # Wrong
  - jekyll-feed

# ✅ CORRECT: Hugo hugo.toml
title = "My Site"                # Correct
[params]                         # Correct
  description = "Site description"
```

## 🔧 PROJECT-SPECIFIC RULES

### Directory Structure
```
jt_site/
├── content/              # Markdown content files
│   ├── blog/            # Blog posts
│   ├── pages/           # Static pages
│   └── _index.md        # Homepage content
├── layouts/             # Template files
│   ├── _default/        # Default layouts
│   ├── partials/        # Reusable components
│   └── shortcodes/      # Custom shortcodes
├── assets/              # Source assets
│   ├── scss/           # SASS/SCSS files
│   ├── js/             # JavaScript files
│   └── images/         # Images for processing
├── static/             # Static files (copied as-is)
├── data/               # YAML/JSON/TOML data files
├── config/             # Configuration files
│   ├── _default/       # Default config
│   ├── production/     # Production overrides
│   └── development/    # Development overrides
├── test/               # Ruby system tests
├── public/             # Generated site (git ignored)
└── resources/          # Hugo cache (git ignored)
```

### Front Matter Requirements
```yaml
---
# Required for posts
title: "Post Title"
date: 2024-03-15T10:00:00Z
draft: false
type: "post"
categories: ["ruby", "development"]
tags: ["hugo", "static-site"]

# Optional
summary: "Brief description"
author: "Author Name"
image: "images/post-header.jpg"
slug: "custom-url-slug"
weight: 10
---
```

### Hugo Module System (PREFERRED)
```toml
# hugo.mod
module "github.com/jetthoughts/jetthoughts.github.io"

go 1.21

require (
  github.com/example/theme v1.0.0
)

# In hugo.toml
[module]
  [[module.imports]]
    path = "github.com/example/theme"
```

### Asset Pipeline with PostCSS
```javascript
// postcss.config.js
module.exports = {
  plugins: [
    require('tailwindcss'),
    require('autoprefixer'),
    require('cssnano')({
      preset: 'default',
    }),
  ],
}

// tailwind.config.js
module.exports = {
  content: [
    './layouts/**/*.html',
    './content/**/*.md',
  ],
  theme: {
    extend: {},
  },
}
```

## 🚨 VALIDATION HOOKS

### Pre-Code Generation
```bash
# Detect Hugo project
if [[ -f "hugo.toml" ]] || [[ -f "config.toml" ]] || [[ -f "config/_default/hugo.toml" ]]; then
  echo "✅ Hugo site detected - loading Hugo patterns"

  # Block wrong SSG patterns
  if [[ -f "_config.yml" ]] && grep -q "jekyll" Gemfile 2>/dev/null; then
    echo "❌ BLOCKED: Jekyll patterns detected in Hugo project"
    exit 1
  fi

  if [[ -f "gatsby-config.js" ]] || [[ -f "next.config.js" ]]; then
    echo "❌ BLOCKED: Non-Hugo SSG detected"
    exit 1
  fi

  # Validate template engine
  if find layouts -name "*.html" -exec grep -l "{% " {} \; 2>/dev/null; then
    echo "❌ BLOCKED: Jekyll/Liquid syntax in Hugo templates"
    exit 1
  fi
fi
```

### Post-Code Validation
```bash
# Validate Hugo template syntax
if [[ "$FILE" == layouts/*.html ]]; then
  if grep -q "{% \|{%- " "$FILE"; then
    echo "❌ Jekyll/Liquid syntax detected (use Go templates)"
    exit 1
  fi

  if grep -q "<%= " "$FILE"; then
    echo "❌ ERB syntax detected (use Go templates)"
    exit 1
  fi
fi

# Validate front matter
if [[ "$FILE" == content/*/*.md ]]; then
  if ! head -1 "$FILE" | grep -q "^---$"; then
    echo "❌ Missing front matter in content file"
    exit 1
  fi
fi

# Validate Hugo configuration
if [[ "$FILE" == *hugo.toml ]] || [[ "$FILE" == config.toml ]]; then
  if grep -q "plugins:" "$FILE"; then
    echo "❌ Jekyll-style plugins config (use Hugo modules)"
    exit 1
  fi
fi
```

### Build Validation
```bash
# Hugo build commands for validation
hugo --minify --gc --cleanDestinationDir  # Production build
hugo --renderToMemory --templateMetrics    # Memory build with metrics
hugo server -D -F --disableFastRender      # Development server
```

## 📊 ENFORCEMENT METRICS

- **Template Compliance**: 100% Go template syntax required
- **Front Matter**: Required for all content files
- **Asset Processing**: Hugo Pipes for all CSS/JS processing
- **Test Coverage**: System tests for critical user flows
- **Build Performance**: <30 seconds for full site generation
- **Configuration**: Environment-specific config files

## 🧪 TESTING PATTERNS

### Ruby System Tests (REQUIRED)
```ruby
# test/system/homepage_test.rb
require 'test_helper'

class HomepageTest < ApplicationSystemTest
  test "homepage renders correctly" do
    visit "/"

    assert_text "JetThoughts"
    assert_css "nav"
    assert_css ".hero-section"
  end

  test "navigation menu works" do
    visit "/"

    click_link "Services"
    assert_current_path "/services/"
  end
end

# test/system/blog_test.rb
class BlogTest < ApplicationSystemTest
  test "blog listing displays posts" do
    visit "/blog/"

    assert_css "article", minimum: 1
    assert_css "article h2"
    assert_css "article time"
  end
end
```

### Hugo Build Tests (REQUIRED)
```bash
# Via package.json scripts
bun run build              # Standard Hugo build
bun run test:build         # Hugo build with validation
bun run test:performance   # Build + Lighthouse audit
```

## 🔗 REFERENCES

- Global Standard: `/knowledge/70.01-tech-stack-consistency-enforcement.md`
- Compatibility Matrix: `/knowledge/70.02-framework-compatibility-matrix.md`
- Hugo Documentation: https://gohugo.io/documentation/
- Go Templates: https://golang.org/pkg/text/template/
- Hugo Modules: https://gohugo.io/hugo-modules/
- PostCSS: https://postcss.org/
- Tailwind CSS: https://tailwindcss.com/

## 📦 PACKAGE.JSON COMMANDS

### Build Commands
```json
{
  "scripts": {
    "build": "hugo",
    "build:production": "hugo --minify --gc --cleanDestinationDir --environment production",
    "build:preview": "hugo --buildDrafts --buildFuture",
    "serve": "hugo server -D -F --bind=0.0.0.0",
    "test": "bin/test",
    "test:build": "hugo build --renderToMemory --templateMetrics",
    "clean": "rm -rf public/ resources/_gen/ .hugo_build.lock"
  }
}
```

### Dependencies
```json
{
  "devDependencies": {
    "@fullhuman/postcss-purgecss": "^7.0.2",
    "autoprefixer": "^10.4.21",
    "cssnano": "^7.1.1",
    "esbuild": "^0.23.1",
    "postcss": "^8.5.6",
    "postcss-cli": "^11.0.1",
    "tailwindcss": "^3.0.0"
  }
}
```

This configuration enforces proper Hugo development patterns while preventing Jekyll, Gatsby, Next.js, or other static site generator patterns from being used in the Hugo-based jt_site project.