# frozen_string_literal: true

require "rake/testtask"
require "fileutils"

# Setup task to prepare test environment
namespace :test do
  # Unit tests only (faster execution)
  Rake::TestTask.new(:unit) do |t|
    t.libs << "test"
    t.libs << "lib"
    t.pattern = "test/unit/**/*_test.rb"
    t.warning = false
  end

  Rake::TestTask.new(:all) do |t|
    ENV["HUGO_ENVIRONMENT"] = "test"

    t.libs << "test"
    t.libs << "lib"
    t.pattern = "test/**/*_test.rb"

    # Performance optimizations
    t.options = "--verbose" if ENV["DEBUG"]
  end

  # System tests only
  Rake::TestTask.new(:system) do |t|
    t.libs << "test"
    t.libs << "lib"
    t.pattern = "test/system/**/*_test.rb"
    t.warning = false
  end

  # Clean up task for test artifacts
  task :clean do
    FileUtils.rm_rf("tmp/capybara") if Dir.exist?("tmp/capybara")
    FileUtils.rm_rf("resources/_gen/*")
    FileUtils.rm_rf("_dest/public-test*") if Dir.glob("_dest/public-test*").any?
    FileUtils.rm_rf("/tmp/hugo_cache_test") if Dir.exist?("/tmp/hugo_cache_test")
    puts "Cleaned up test artifacts"
  end

  task :setup do
    FileUtils.mkdir_p("tmp/capybara")
    FileUtils.mkdir_p("/tmp/hugo_cache_test")
    puts "Test environment prepared"
  end
end

task default: "test:all"
