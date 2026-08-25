# Gemfile
source "https://rubygems.org"

gem "minitest"
gem "capybara"
gem "launchy"
gem "httparty"
gem "faraday"
gem "selenium-webdriver"
gem "rack"
gem "rackup"
gem "puma"
gem "ostruct"

gem "sanity-ruby"

# 2.0.0.beta4 is the current 2.0 prerelease; pin the exact version - Bundler
# never resolves a prerelease from a plain requirement (`~> 2.0` fails until
# 2.0.0 ships, then the pin becomes `~> 2.0`). snap_diff-capybara and
# capybara-screenshot-diff are the same gem under two names - install one,
# never both (a dual install raises SnapDiff::DualInstallError at require).
gem "snap_diff-capybara", "2.0.0.beta4"
gem "simplecov", require: false
gem "vips"

# system libs
gem "bigdecimal", require: false
gem "mutex_m", require: false

# tools
gem "standard", require: false
gem "html-proofer", require: false

gem "rake", "~> 13.3"
