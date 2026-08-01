# JetThoughts Website

> Professional software development consultancy website built with Hugo, featuring automated content synchronization from dev.to and comprehensive CI/CD pipeline.

[![Hugo](https://img.shields.io/badge/Hugo-Extended-ff4088.svg)](https://gohugo.io/)
[![GitHub Pages](https://img.shields.io/badge/Deployed%20on-GitHub%20Pages-blue)](https://jetthoughts.com/)
[![CI/CD](https://github.com/jetthoughts/jetthoughts.github.io/actions/workflows/publish.yml/badge.svg)](https://github.com/jetthoughts/jetthoughts.github.io/actions)

## 📋 Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Technology Stack](#technology-stack)
- [Quick Start](#quick-start)
- [Development](#development)
- [Testing](#testing)
- [Deployment](#deployment)
- [Content Management](#content-management)
- [Documentation](#documentation)
- [Contributing](#contributing)
- [License](#license)

## 🌟 Overview

JetThoughts website is a sophisticated static site generator project that showcases the company's software development and consultancy services. The site features automated blog content synchronization from dev.to, a custom Hugo theme, and comprehensive testing framework.

### Key Highlights

- **540+ technical articles** automatically synced from dev.to
- **Responsive design** with mobile-first approach
- **Visual regression testing** to ensure consistency
- **Automated CI/CD** with GitHub Actions
- **SEO optimized** with proper meta tags and structured data
- **Performance optimized** with PurgeCSS and asset minification

## ✨ Features

### Content Features
- **Dynamic blog system** with automated dev.to synchronization
- **Service showcases** for consultancy offerings
- **Client case studies** and success stories
- **Use case demonstrations**
- **Career opportunities** with Google Forms integration
- **Contact system** with form submissions

### Technical Features
- **Static site generation** with Hugo Extended
- **Automated content sync** every 10 minutes
- **Visual regression testing** with screenshot comparison
- **Staging environment** with surge.sh deployment
- **Multi-level navigation** with dropdown menus
- **Asset optimization** with PostCSS pipeline
- **Git-based versioning** for content

## 🛠 Technology Stack

### Core Technologies

| Category | Technologies |
|----------|-------------|
| **Static Site Generator** | Hugo Extended (version pinned in `.mise.toml`) |
| **Theme** | Custom "Beaver" theme |
| **Languages** | HTML, CSS (PostCSS), JavaScript, Ruby |
| **Package Managers** | Bun (Node.js), Bundler (Ruby) |
| **Testing** | Minitest, Capybara, Selenium WebDriver |
| **CI/CD** | GitHub Actions, GitHub Pages |
| **Content Source** | dev.to API integration |

### Dependencies

#### Bun Dependencies
```json
{
  "build": ["@fullhuman/postcss-purgecss", "autoprefixer", "cssnano", "postcss"],
  "audit": ["lighthouse", "markdownlint-cli"],
  "deployment": ["surge"]
}
```

#### Ruby Dependencies
```ruby
# Testing
gem "minitest"
gem "capybara"
gem "selenium-webdriver"
gem "capybara-screenshot-diff"

# API & HTTP
gem "httparty"
gem "faraday"
gem "sanity-ruby"

# Development
gem "standard"
gem "simplecov"
```

## 🚀 Quick Start

### Prerequisites

- **[mise](https://mise.jdx.dev)** — installs the pinned toolchain (Hugo Extended, Bun, Node, Ruby) from `.mise.toml`
- **libvips** — screenshot-diff tests (`brew install vips` / `apt-get install libvips42`)
- **Chrome or Chromium** — system tests (set `CHROME_BIN=/path/to/chrome` if not on PATH)
- **Git** for version control

Exact versions live in `.mise.toml` (mirrored in `.ruby-version`); CI pins are
kept in sync by `test/unit/toolchain_pins_test.rb`. See [docs/SETUP.md](docs/SETUP.md)
for the full walkthrough.

### Installation

1. **Clone the repository:**
```bash
git clone https://github.com/jetthoughts/jetthoughts.github.io.git
cd jetthoughts.github.io
```

2. **Run the setup script:**
```bash
bin/setup
```

This installs the pinned toolchain via mise, system libraries via
Brewfile/apt, JS dependencies via Bun, and Ruby gems via Bundler — then runs
a doctor that verifies each piece and prints a fix for anything missing.

3. **Start the development server:**
```bash
bin/dev
```

Visit `http://localhost:1313` to view the site. (`bin/dev` wraps
`hugo server` with the PATH and env the PostCSS pipeline needs — a bare
`hugo server -D` will fail to build CSS.)

## 💻 Development

### Project Structure

```
jetthoughts.github.io/
├── content/           # Content files (markdown)
│   ├── blog/         # Blog posts (synced from dev.to)
│   ├── pages/        # Static pages
│   ├── clients/      # Client case studies
│   ├── services/     # Service descriptions
│   └── use-cases/    # Use case examples
├── themes/beaver/     # Custom theme
│   ├── layouts/      # Template files
│   ├── assets/       # Theme assets
│   └── archetypes/   # Content templates
├── assets/           # Site assets (images, etc.)
├── data/             # Data files (YAML)
├── static/           # Static files
├── lib/              # Ruby libraries for sync
├── test/             # Test suite
└── bin/              # Utility scripts
```

### Available Commands

| Command | Description |
|---------|-------------|
| `bin/dev` | Start development server with drafts |
| `bin/hugo-build` | Build + validate site (course validators, PurgeCSS warm-up) |
| `bin/test` | Run critical test suite (`bin/rake test:critical`) |
| `bin/qtest` | Scoped visual gate for a changed CSS file/page (fast, budgeted) |
| `bin/dtest` | Same suite in Linux/Docker (visual baselines CI-parity) |
| `bin/dtest-all` | Full suite in Docker, detached (log in `tmp/dtest-all.log`) |
| `bin/setup-test-env` | Install the pinned Chrome-for-Testing + fonts stack bare-metal |
| `bin/rake test:screenshots:reset` | Restore overwritten screenshot baselines |
| `bin/lint-css` | Stylelint warning ratchet |
| `bin/sync_with_devto` | Sync blog posts from dev.to |
| `bin/surge/deploy` | Deploy to staging (surge.sh) |
| `bin/setup` | Initial project setup + doctor |

### Environment Variables

Create a `.env` file for local development:

```bash
# API Keys
DEVTO_API_KEY=your_dev_to_api_key

# Deployment
SURGE_DOMAIN=your-staging-domain.surge.sh

# Testing (see docs/SETUP.md for the pinned-browser flow)
CHROME_BIN=...             # optional: explicit Chrome binary for system tests
CHROMEDRIVER_PATH=...      # optional: matching chromedriver
ALLOW_DIRTY_SCREENSHOTS=1  # bypass the dirty-baseline guard intentionally
```

## 🧪 Testing

The project includes comprehensive testing with multiple test types:

### Running Tests

```bash
# Critical suite (system + visual regression)
bin/test

# Specific suites
bin/rake test:unit          # Unit tests (validators, sync, templates)
bin/rake test:system        # All system tests
bin/rake test:critical      # Critical pages subset
bin/dtest                   # Critical suite in Linux/Docker

# Single test file
bin/test test/system/desktop_site_test.rb
```

### Test Categories

1. **Unit Tests** - Test individual components and functions
2. **System Tests** - Full browser automation tests
3. **Visual Regression** - Screenshot comparison tests
4. **Integration Tests** - API and external service tests

## 📦 Deployment

### Production Deployment

The site automatically deploys to GitHub Pages when changes are pushed to the `master` branch:

1. **Push to master:**
```bash
git push origin master
```

2. **GitHub Actions workflow:**
   - Builds the site with Hugo
   - Runs tests
   - Deploys to GitHub Pages

### Staging Deployment

Deploy to surge.sh for testing:

```bash
bin/surge/deploy
```

Access staging at: `https://your-domain.surge.sh`

## 📝 Content Management

### Blog Posts

Blog posts are automatically synchronized from dev.to:

#### Automatic Sync
- Runs every 10 minutes via GitHub Actions
- Syncs posts tagged with "jetthoughts" organization

#### Manual Sync
```bash
bin/sync_with_devto [options]

Options:
  --dry        Preview changes without syncing
  --force      Force sync all articles
  --dry --force Preview forced sync
```

#### Creating New Posts

1. **Write on dev.to:**
   - Publish under JetThoughts organization
   - Add relevant tags (first 2 tags used in URL)
   
2. **Trigger sync:**
   - Wait for automatic sync (10 minutes)
   - Or run manual sync command

#### URL Management

Custom URLs can be configured in `devto_urls_mapping.csv`:
```csv
article_id,custom_url
12345,/blog/my-custom-url/
```

### Static Pages

Create new pages using Hugo archetypes:

```bash
# Create a new service page
hugo new services/new-service/index.md

# Create a new client case study
hugo new clients/new-client/index.md

# Create a new use case
hugo new use-cases/new-use-case/index.md
```

### Menu Configuration

Edit `hugo.toml` to modify navigation:

```toml
[[menu.main]]
  identifier = "new-item"
  name = "New Item"
  pageRef = "pages/new-item/"
  weight = 70
```

## 📚 Documentation

### Available Documentation

| Document | Description |
|----------|-------------|
| [README.md](README.md) | Project overview and setup |
| [CONTRIBUTING.md](CONTRIBUTING.md) | Contribution guidelines |
| [SETUP.md](docs/SETUP.md) | Detailed setup instructions |
| [CI-CD](docs/50-59-deployment-operations/50.02-ci-cd-pipeline-analysis-reference.md) | CI/CD pipeline documentation |
| [DEV-TO-INTEGRATION](docs/80-89-integration-apis/80.01-dev-to-integration-how-to.md) | dev.to sync documentation |
| [AGENT-GUIDANCE.md](docs/60-69-project-management/60.01-agent-guidance-reference.md) | Agent resource locations and guidelines |

### API Documentation

The project includes several internal APIs and scripts:

- **Sync API** (`lib/sync/`) - Handles dev.to synchronization
- **Testing API** (`test/`) - Test utilities and helpers
- **Build Scripts** (`bin/`) - Automation scripts

## 🤝 Contributing

We welcome contributions! Please see our [Contributing Guidelines](CONTRIBUTING.md) for details.

### Quick Contribution Steps

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Make your changes
4. Run tests (`bin/test`)
5. Commit changes (`git commit -m 'Add amazing feature'`)
6. Push to branch (`git push origin feature/amazing-feature`)
7. Open a Pull Request

## 📄 License

This work is licensed under a [Creative Commons Attribution-ShareAlike 4.0 International License](https://creativecommons.org/licenses/by-sa/4.0/).

## 🙏 Acknowledgments

- Hugo static site generator team
- dev.to for content platform integration
- GitHub for hosting and CI/CD
- All contributors and maintainers

## 📞 Contact

- **Website:** [https://jetthoughts.com](https://jetthoughts.com)
- **Email:** info@jetthoughts.com
- **Phone:** +1 754 216 9568
- **GitHub:** [@jetthoughts](https://github.com/jetthoughts)

---

<p align="center">Made with ❤️ by JetThoughts Team</p>