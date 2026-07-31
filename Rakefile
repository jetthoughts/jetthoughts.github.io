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
    t.pattern = "test/system/**/*_test.rb"
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

  namespace :screenshots do
    desc "Restore baseline PNGs rewritten by a test run (candidates live in the working tree; git HEAD is the baseline)"
    task :reset do
      sh "git checkout -- test/fixtures/screenshots"
    end
  end

  # Broken-link checks (2026-07-21: GA 404 spike audit). Coverage is total by
  # construction - every *.html the build emits is globbed from disk and
  # passed to lychee as an explicit input, so nothing is skipped the way a
  # single-URL or sitemap-only scan would skip.
  #
  # These build with ENVIRONMENT=production (not the top-level :build task's
  # dev default) rather than depending on :build - config/development/hugo.toml
  # disables the taxonomy/term page kinds for build speed, which would make
  # every real /blog/tags/* link on the site look broken.
  def build_for_linkcheck(dir)
    sh({ "ENVIRONMENT" => "production", "OUTPUT_DIR" => dir }, "./bin/hugo-build")
  end

  desc "Broken internal links (offline, blocking) via lychee"
  task :links do
    dir = ENV.fetch("OUTPUT_DIR", "_dest/public-linkcheck")
    build_for_linkcheck(dir)
    html_files = Dir.glob("#{dir}/**/*.html")
    abort "No HTML files found in #{dir} - did the build fail?" if html_files.empty?
    puts "lychee: scanning #{html_files.size} pages for broken internal links..."
    sh("lychee", "--offline", "--no-progress", "--root-dir", File.expand_path(dir), "#{dir}/**/*.html")
  end

  # Same page set including external links. Non-blocking: third-party
  # uptime/rate-limits (e.g. jtway.co) are outside our control.
  desc "Broken links incl. external (non-blocking report) via lychee"
  task :links_external do
    dir = ENV.fetch("OUTPUT_DIR", "_dest/public-linkcheck")
    build_for_linkcheck(dir)
    html_files = Dir.glob("#{dir}/**/*.html")
    puts "lychee: scanning #{html_files.size} pages for broken links (internal + external)..."
    begin
      sh("lychee", "--no-progress", "--root-dir", File.expand_path(dir), "#{dir}/**/*.html")
    rescue RuntimeError => e
      puts "\nlychee reported failures (non-blocking): #{e.message}"
    end
  end

  # CI-only complement to :links - html-proofer catches a few things lychee
  # doesn't (missing image src files, malformed hash fragments). Internal-only
  # and non-blocking, matching :links_external's failure handling.
  desc "HTML/link/image validation via html-proofer (CI option, non-blocking)"
  task :html_proofer do
    dir = ENV.fetch("OUTPUT_DIR", "_dest/public-linkcheck")
    build_for_linkcheck(dir)
    begin
      sh("bundle", "exec", "htmlproofer", dir, "--disable-external", "--checks", "Links,Images")
    rescue RuntimeError => e
      puts "\nhtml-proofer reported failures (non-blocking): #{e.message}"
    end
  end
end

desc "Build the site (Hugo)"
task :build do
  sh "./bin/hugo-build"
end

desc "Run server (Hugo)"
task :dev do
  # bin/dev (not the retired bin/hugo-dev): it exports HUGO_ENVIRONMENT so
  # PostCSS actually runs in dev mode - the old script left it unset and paid
  # the full PurgeCSS+cssnano production chain on every CSS rebuild.
  sh "./bin/dev"
end

desc "Crawl site and run Lighthouse on each page (bin/lighthouse)"
task :lighthouse, [:limit] do |_t, args|
  cmd = "./bin/lighthouse"
  cmd += " --limit #{args[:limit]}" if args[:limit]
  sh cmd
end

task default: "test:all"
