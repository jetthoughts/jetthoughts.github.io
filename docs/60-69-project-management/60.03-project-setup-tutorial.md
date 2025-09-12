# JetThoughts Website - Detailed Setup Guide

## Prerequisites

Before setting up the project, ensure you have the following installed on your system:

### Required Software

| Software | Version | Check Command | Installation |
|----------|---------|---------------|--------------|
| **Git** | 2.25+ | `git --version` | [git-scm.com](https://git-scm.com/) |
| **Hugo Extended** | 0.147.9+ | `hugo version` | See [Hugo Installation](#hugo-installation) |
| **Bun** or **Node.js** | Latest / 18+ | `bun -v` or `node -v` | [bun.sh](https://bun.sh/) or [nodejs.org](https://nodejs.org/) |
| **Ruby** | 3.0+ | `ruby -v` | [ruby-lang.org](https://www.ruby-lang.org/) |
| **Bundler** | 2.0+ | `bundle -v` | `gem install bundler` |

### Optional Software

- **Go** (1.19+) - For Hugo module development
- **Chrome/Chromium** - For testing with Selenium
- **ImageMagick** - For image processing

## Installation Steps

### Step 1: Hugo Installation

Hugo Extended is required for SCSS/Sass support.

#### macOS (Homebrew)
```bash
brew install hugo
```

#### Linux (Snap)
```bash
snap install hugo --channel=extended
```

#### Windows (Chocolatey)
```powershell
choco install hugo-extended
```

#### Manual Installation
1. Download from [Hugo Releases](https://github.com/gohugoio/hugo/releases)
2. Choose the **extended** version for your OS
3. Extract and add to PATH

Verify installation:
```bash
hugo version
# Should show: hugo v0.147.9-extended ...
```

### Step 2: Clone Repository

```bash
# Clone the repository
git clone https://github.com/jetthoughts/jetthoughts.github.io.git
cd jetthoughts.github.io

# Or use SSH
git clone git@github.com:jetthoughts/jetthoughts.github.io.git
cd jetthoughts.github.io
```

### Step 3: Run Setup Script

The automated setup script handles all dependencies:

```bash
bin/setup
```

This script will:
1. Check for required software
2. Install Ruby gems via Bundler
3. Install Node packages via Bun/npm
4. Set up git hooks (if applicable)
5. Create necessary directories
6. Initialize configuration files

### Step 4: Manual Setup (Alternative)

If the setup script fails or you prefer manual installation:

#### Install Ruby Dependencies
```bash
# Install bundler if not present
gem install bundler

# Install Ruby gems
bundle install

# Or with specific path
bundle install --path vendor/bundle
```

#### Install Node Dependencies
```bash
# Using Bun (recommended)
bun install

# Or using npm
npm install

# Or using yarn
yarn install
```

### Step 5: Environment Configuration

Create a `.env` file for local development:

```bash
# Copy example environment file
cp .env.example .env 2>/dev/null || touch .env

# Edit with your configuration
cat << 'EOF' > .env
# Development Environment Variables

# API Keys (optional)
DEVTO_API_KEY=your_dev_to_api_key_here

# Deployment Configuration
SURGE_DOMAIN=your-project.surge.sh

# Testing Configuration
SELENIUM_BROWSER=chrome_headless
SELENIUM_DRIVER_PATH=/usr/local/bin/chromedriver

# Hugo Configuration (optional)
HUGO_ENVIRONMENT=development
HUGO_BASEURL=http://localhost:1313

# Performance
HUGO_NUMWORKERMULTIPLIER=4
EOF
```

## Development Setup

### Starting the Development Server

```bash
# Basic development server
hugo server

# With drafts and future posts
hugo server -D -F

# With verbose output
hugo server --verbose

# On custom port
hugo server --port 3000

# Bind to all interfaces (for network access)
hugo server --bind 0.0.0.0
```

Access the site at: `http://localhost:1313`

### Development Commands

| Command | Description |
|---------|-------------|
| `hugo server -D` | Start dev server with drafts |
| `hugo new content/blog/post-name.md` | Create new blog post |
| `hugo new services/service-name/index.md` | Create new service page |
| `hugo --gc --minify` | Build production site |
| `bin/sync_with_devto` | Sync blog from dev.to |

## Testing Setup

### Browser Driver Installation

For Selenium-based testing:

#### Chrome Driver
```bash
# macOS
brew install chromedriver

# Linux
sudo apt-get install chromium-chromedriver

# Or download manually
wget https://chromedriver.storage.googleapis.com/LATEST_RELEASE
```

#### Firefox Driver (Geckodriver)
```bash
# macOS
brew install geckodriver

# Linux
sudo apt-get install firefox-geckodriver
```

### Running Tests

```bash
# Run all tests
ruby test/test_helper.rb

# Run specific test file
ruby test/test_homepage.rb

# Run with coverage
COVERAGE=true ruby test/test_helper.rb

# Run in different browser
SELENIUM_BROWSER=firefox ruby test/test_system.rb
```

### Test Configuration

Edit `test/test_helper.rb` for custom configuration:

```ruby
# Browser configuration
Capybara.default_driver = :chrome_headless
Capybara.javascript_driver = :chrome

# Server configuration
Capybara.app_host = 'http://localhost:1313'
Capybara.server_port = 1313
```

## Content Synchronization Setup

### dev.to API Configuration

1. **Get API Key** from [dev.to Settings](https://dev.to/settings/account)
2. **Add to environment**:
   ```bash
   echo "DEVTO_API_KEY=your_api_key" >> .env
   ```

3. **Test synchronization**:
   ```bash
   bin/sync_with_devto --dry
   ```

### URL Mapping Configuration

Edit `seo/devto_urls_mapping.csv`:
```csv
article_id,custom_url
123456,/blog/my-custom-url/
789012,/blog/another-custom-url/
```

### Sync Status Tracking

The sync status is tracked in `content/blog/sync_status.yml`:
```yaml
articles:
  123456:
    last_synced: 2024-01-01T00:00:00Z
    local_path: content/blog/my-post/index.md
    canonical_url: https://jetthoughts.com/blog/my-post/
```

## Deployment Setup

### GitHub Pages (Production)

1. **Repository Settings**:
   - Go to Settings → Pages
   - Source: Deploy from a branch
   - Branch: gh-pages
   - Folder: / (root)

2. **GitHub Actions** (automatic):
   - Workflows in `.github/workflows/`
   - Triggers on push to master
   - Builds and deploys automatically

### Surge.sh (Staging)

1. **Install Surge**:
   ```bash
   npm install -g surge
   # or
   bun add -g surge
   ```

2. **Configure domain**:
   ```bash
   echo "your-project.surge.sh" > CNAME
   ```

3. **Deploy**:
   ```bash
   bin/surge/deploy
   # or manually
   surge public/ your-project.surge.sh
   ```

## Troubleshooting

### Common Issues and Solutions

#### Hugo Build Errors

**Problem**: `Error: failed to transform resource`
```bash
# Solution: Clear Hugo cache
rm -rf resources/_gen
hugo --gc
```

**Problem**: `TOCSS: failed to transform`
```bash
# Solution: Ensure Hugo Extended is installed
hugo version
# Should show "extended"
```

#### Ruby/Bundle Issues

**Problem**: `Could not find gem`
```bash
# Solution: Update bundler and retry
gem update bundler
bundle install
```

**Problem**: `Permission denied`
```bash
# Solution: Install to user directory
bundle install --path vendor/bundle
```

#### Node/Bun Issues

**Problem**: `Cannot find module`
```bash
# Solution: Clear cache and reinstall
rm -rf node_modules bun.lockb
bun install
```

#### Testing Issues

**Problem**: `Selenium::WebDriver::Error`
```bash
# Solution: Update browser driver
brew upgrade chromedriver
# or
npm install -g chromedriver
```

**Problem**: `Net::ReadTimeout`
```bash
# Solution: Increase timeout in test_helper.rb
Capybara.default_max_wait_time = 10
```

### Debug Mode

Enable verbose output for troubleshooting:

```bash
# Hugo debug
hugo server --debug --verbose

# Ruby debug
RUBY_DEBUG=true ruby test/test_helper.rb

# Sync debug
DEBUG=true bin/sync_with_devto
```

## Performance Optimization

### Build Performance

```bash
# Parallel builds
hugo --numWorkerMultiplier 4

# Skip unused formats
hugo --disableKinds=RSS,sitemap

# Production build with all optimizations
hugo --gc --minify --cleanDestinationDir
```

### Development Performance

```bash
# Fast rebuilds (skip unchanged)
hugo server --disableFastRender=false

# Memory cache
hugo server --meminterval 1s

# Disable live reload for large sites
hugo server --disableLiveReload
```

## IDE Setup

### VS Code

Recommended extensions:
```json
{
  "recommendations": [
    "budparr.language-hugo-vscode",
    "bungcip.better-toml",
    "esbenp.prettier-vscode",
    "rebornix.ruby",
    "castwide.solargraph"
  ]
}
```

Settings (`.vscode/settings.json`):
```json
{
  "files.associations": {
    "*.html": "go-html-template"
  },
  "emmet.includeLanguages": {
    "go-html-template": "html"
  }
}
```

### RubyMine/IntelliJ

1. Install Hugo plugin
2. Configure Ruby SDK
3. Set up run configurations for tests
4. Configure file watchers for Hugo

## Continuous Integration

### Local CI Testing

Run CI checks locally before pushing:

```bash
# Create local CI script
cat << 'EOF' > bin/ci-local
#!/bin/bash
set -e

echo "🔍 Running local CI checks..."

echo "📦 Installing dependencies..."
bundle install
bun install

echo "🏗️ Building site..."
hugo --gc --minify

echo "🧪 Running tests..."
ruby test/test_helper.rb

echo "✅ All checks passed!"
EOF

chmod +x bin/ci-local
./bin/ci-local
```

## Security Configuration

### API Key Management

Never commit API keys. Use environment variables:

```bash
# Good ✅
export DEVTO_API_KEY=$(cat ~/.secrets/devto_key)

# Bad ❌
DEVTO_API_KEY=sk-1234567890abcdef
```

### Git Secrets

Install git-secrets to prevent accidental commits:
```bash
brew install git-secrets
git secrets --install
git secrets --register-aws
```

## Next Steps

After setup is complete:

1. **Explore the codebase** - Review project structure
2. **Read documentation** - Check `docs/` folder
3. **Run tests** - Ensure everything works
4. **Make a test change** - Try editing content
5. **Join the team** - Contact for dev.to access

## Support

If you encounter issues:

1. Check this troubleshooting guide
2. Search existing [GitHub Issues](https://github.com/jetthoughts/jetthoughts.github.io/issues)
3. Create a new issue with:
   - System information
   - Error messages
   - Steps to reproduce
4. Contact team at info@jetthoughts.com

---

<p align="center">
  <em>Happy developing! 🚀</em>
</p>
