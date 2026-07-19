# frozen_string_literal: true

require "rake/testtask"

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.libs << "lib"
  t.pattern = "test/**/*_test.rb"
end

namespace :test do
  Rake::TestTask.new(:all) do |t|
    t.libs << "test"
    t.libs << "lib"
    t.pattern = "test/**/*_test.rb"
  end

  Rake::TestTask.new(:unit) do |t|
    t.libs << "test"
    t.libs << "lib"
    t.pattern = "test/unit/**/*_test.rb"
  end

  # Highest-risk pages only (~2 min): selection grounded in git churn
  # (2026-07-19 analysis: blog + homepage + course + site-wide dominate
  # 6-month history) + the lead-gen funnel (services, contact,
  # free-consultation). Full system suite = test:system; everything = test:all.
  CRITICAL_TESTS =
    "/homepage|blog_index|blog_post$|visit_blog_post|course_|old_blog_url|" \
    "test_services($|_menu)|contact_us|free_consultation|not_found|" \
    "hamburger|color_system|mermaid|codeblock_language/"

  Rake::TestTask.new(:critical) do |t|
    t.libs << "test"
    t.libs << "lib"
    t.pattern = "test/system/*_test.rb"
    t.options = "--name='#{CRITICAL_TESTS}'"
  end

  Rake::TestTask.new(:system) do |t|
    t.libs << "test"
    t.libs << "lib"
    t.pattern = "test/system/**/*_test.rb"
  end

  Rake::TestTask.new(:integration) do |t|
    t.libs << "test"
    t.libs << "lib"
    t.pattern = "test/integration/**/*_test.rb"
  end
end

desc "Build the site (Hugo)"
task :build do
  sh "./bin/hugo-build"
end

desc "Run server (Hugo)"
task :dev do
  sh "./bin/hugo-dev"
end

desc "Crawl site and run Lighthouse on each page (bin/lighthouse)"
task :lighthouse, [:limit] do |_t, args|
  cmd = "./bin/lighthouse"
  cmd += " --limit #{args[:limit]}" if args[:limit]
  sh cmd
end

task default: "test:all"
