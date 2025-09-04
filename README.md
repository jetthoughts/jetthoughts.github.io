# JetThoughts Website

> Professional software development consultancy website built with Hugo, featuring automated content synchronization from dev.to and comprehensive CI/CD pipeline.

[![Hugo](https://img.shields.io/badge/Hugo-0.147.9-ff4088.svg)](https://gohugo.io/)
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
| **Static Site Generator** | Hugo v0.147.9 Extended |
| **Theme** | Custom "Beaver" theme |
| **Languages** | HTML, CSS (PostCSS), JavaScript, Ruby |
| **Package Managers** | Bun (Node.js), Bundler (Ruby) |
| **Testing** | Minitest, Capybara, Selenium WebDriver |
| **CI/CD** | GitHub Actions, GitHub Pages |
| **Content Source** | dev.to API integration |

### Dependencies

#### Node.js Dependencies
```json
{
  "build": ["@fullhuman/postcss-purgecss", "autoprefixer", "cssnano", "esbuild"],
  "formatting": ["prettier", "prettier-plugin-go-template"],
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

- **Hugo Extended** v0.147.9 or higher
- **Bun** or Node.js v18+
- **Ruby** 3.0+ with Bundler
- **Git** for version control

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

This will automatically:
- Install Hugo if not present
- Install Node.js dependencies via Bun
- Install Ruby gems via Bundler
- Set up pre-commit hooks

3. **Start the development server:**
```bash
hugo server -D
```

Visit `http://localhost:1313` to view the site.

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
| `hugo server -D` | Start development server with drafts |
| `hugo build` | Build production site |
| `npm run test` | Run test suite |
| `bin/sync_with_devto` | Sync blog posts from dev.to |
| `bin/surge/deploy` | Deploy to staging (surge.sh) |
| `bin/setup` | Initial project setup |

### Environment Variables

Create a `.env` file for local development:

```bash
# API Keys
DEVTO_API_KEY=your_dev_to_api_key

# Deployment
SURGE_DOMAIN=your-staging-domain.surge.sh

# Testing
SELENIUM_BROWSER=chrome_headless
```

## 🧪 Testing

The project includes comprehensive testing with multiple test types:

### Running Tests

```bash
# Run all tests
npm run test

# Run specific test type
ruby test/test_blog_sync.rb      # Unit tests
ruby test/test_system.rb         # System tests
ruby test/test_homepage.rb       # Homepage tests
```

### Test Categories

1. **Unit Tests** - Test individual components and functions
2. **System Tests** - Full browser automation tests
3. **Visual Regression** - Screenshot comparison tests
4. **Integration Tests** - API and external service tests

### Coverage Reports

Test coverage reports are generated automatically:
```bash
open coverage/index.html
```

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
| [ARCHITECTURE.md](docs/ARCHITECTURE.md) | Technical architecture details |
| [CONTRIBUTING.md](CONTRIBUTING.md) | Contribution guidelines |
| [SETUP.md](docs/SETUP.md) | Detailed setup instructions |
| [CI-CD.md](docs/ci-cd-pipeline-analysis.md) | CI/CD pipeline documentation |
| [DEV-TO-INTEGRATION.md](docs/dev-to-integration-guide.md) | dev.to sync documentation |

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
4. Run tests (`npm run test`)
5. Commit changes (`git commit -m 'Add amazing feature'`)
6. Push to branch (`git push origin feature/amazing-feature`)
7. Open a Pull Request

## 📄 License

This work is licensed under a Creative Commons Attribution-ShareAlike 4.0 International License. See the [LICENSE](LICENSE) file for details.

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