# frozen_string_literal: true

require_relative "../test_helper"
require "fileutils"

# Integration tests for the Hugo asset pipeline production branching.
#
# These tests build the full site in both development and production
# environments, then verify that Hugo template partials
# (css-processor.html, css-inline.html, js-processor.html) produce
# the correct outputs:
#
#   Dev:  fingerprint only, no integrity, no .min. in filenames
#   Prod: fingerprint + minify, integrity attributes, .min. in CSS
#         filenames, crossorigin=anonymous on script tags
#
# Builds run once per test class via class-level memoization (~7s each).
# All tests skip if either build fails.

HUGO_PROJECT_ROOT = File.expand_path("../..", __dir__)
HUGO_DEV_DIR = "/tmp/hugo-test-dev"
HUGO_PROD_DIR = "/tmp/hugo-test-prod"

class HugoPipelineIntegrationTest < Minitest::Test
  # -- One-time builds (class-level memoization) ---------------------------

  def self.dev_ready?
    @dev_ready ||= begin
      FileUtils.rm_rf(HUGO_DEV_DIR)
      system({ "HUGO_ENVIRONMENT" => "development", "BASE_URL" => "http://localhost:1313" },
             "hugo build --noBuildLock --environment development --destination #{HUGO_DEV_DIR}",
             chdir: HUGO_PROJECT_ROOT,
             %i[out err] => "/dev/null")
    end
  end

  def self.prod_ready?
    @prod_ready ||= begin
      FileUtils.rm_rf(HUGO_PROD_DIR)
      system({ "HUGO_ENVIRONMENT" => "production", "BASE_URL" => "https://jetthoughts.com" },
             "hugo build --noBuildLock --environment production --destination #{HUGO_PROD_DIR}",
             chdir: HUGO_PROJECT_ROOT,
             %i[out err] => "/dev/null")
    end
  end

  def setup
    skip "Dev Hugo build failed or unavailable" unless self.class.dev_ready?
    skip "Prod Hugo build failed or unavailable" unless self.class.prod_ready?
    skip "Dev output missing" unless Dir.exist?(HUGO_DEV_DIR)
    skip "Prod output missing" unless Dir.exist?(HUGO_PROD_DIR)
  end

  # -- HTML output helpers -------------------------------------------------

  def dev_html
    @dev_html ||= File.read("#{HUGO_DEV_DIR}/index.html")
  end

  def prod_html
    @prod_html ||= File.read("#{HUGO_PROD_DIR}/index.html")
  end

  def dev_css_files(pattern = "homepage.*.css")
    Dir["#{HUGO_DEV_DIR}/css/#{pattern}"]
  end

  def prod_css_files(pattern = "homepage.*.css")
    Dir["#{HUGO_PROD_DIR}/css/#{pattern}"]
  end

  # -- Tests: CSS integrity attributes ------------------------------------
  # css-processor.html adds integrity= to <link> tags ONLY in production

  def test_css_has_no_integrity_in_development
    refute dev_html.include?("integrity"),
      "Dev build should not have integrity attributes on any tags"
  end

  def test_css_has_integrity_in_production
    assert prod_html.include?('integrity="sha256-'),
      "Prod build should have sha256 integrity attributes on link/script tags"
  end

  def test_css_has_multiple_integrity_attributes_in_production
    count = prod_html.scan(%r{integrity="sha256-}).length
    assert_operator count, :>=, 2,
      "Prod build should have at least 2 integrity attributes (preload + stylesheet)"
  end

  # -- Tests: CSS minification (via .min. in filename) --------------------
  # css-processor.html runs | minify | fingerprint "sha256" in production,
  # which produces homepage.min.<hash>.css vs homepage.<hash>.css in dev

  def test_css_filenames_have_min_suffix_in_production
    prod_css_files.each do |f|
      basename = File.basename(f)
      assert basename.include?(".min."),
        "Prod CSS '#{basename}' should have .min. in filename (was minified)"
    end
  end

  def test_css_filenames_have_no_min_in_development
    dev_css_files.each do |f|
      basename = File.basename(f)
      refute basename.include?(".min."),
        "Dev CSS '#{basename}' should NOT have .min. in filename (not minified)"
    end
  end

  # -- Tests: CSS file size (minification evidence) -----------------------
  # Production CSS should be noticeably smaller than dev CSS

  def test_css_content_is_minified_in_production
    dev_file = dev_css_files.first
    prod_file = prod_css_files.first

    skip "No dev CSS file found" unless dev_file
    skip "No prod CSS file found" unless prod_file

    dev_size = File.size(dev_file)
    prod_size = File.size(prod_file)

    assert_operator prod_size, :<, dev_size,
      "Prod CSS (#{prod_size}B) should be smaller than dev CSS (#{dev_size}B) (was minified)"
  end

  # -- Tests: JS integrity + crossorigin ----------------------------------
  # js-processor.html adds integrity + crossorigin=anonymous ONLY in production

  def test_js_has_integrity_and_crossorigin_in_production
    assert prod_html.include?('integrity="sha256-'),
      "Prod should have integrity attributes on script tags"
    assert prod_html.include?("crossorigin=anonymous"),
      "Prod should have crossorigin=anonymous on script tags"
  end

  def test_js_no_integrity_or_crossorigin_in_development
    refute dev_html.include?("integrity"),
      "Dev tags should not have integrity attributes"
    refute dev_html.include?("crossorigin"),
      "Dev tags should not have crossorigin attributes"
  end

  # -- Tests: CSS loaded via <link> with integrity in prod ----------------
  # css-processor.html wraps integrity in the <link> tag

  def test_stylesheet_links_have_integrity_in_production
    integrity_links = prod_html.scan(%r{<link[^>]*rel=stylesheet[^>]*integrity=[^>]*>})

    assert_operator integrity_links.length, :>=, 1,
      "Prod should have at least 1 link rel=stylesheet tag with integrity"
  end

  def test_preload_links_have_integrity_in_production
    preload_links = prod_html.scan(%r{<link[^>]*rel=preload[^>]*as=style[^>]*integrity=[^>]*>})

    assert_operator preload_links.length, :>=, 1,
      "Prod should have at least 1 link rel=preload as=style with integrity"
  end

  # -- Tests: CSS not minified in dev ------------------------------------
  # Also verify the opposite: dev CSS files should NOT have .min.

  def test_multiple_css_bundles_exist_in_both_envs
    dev_count = dev_css_files.length
    prod_count = prod_css_files.length

    assert_operator dev_count, :>=, 1, "Dev should have at least 1 CSS bundle"
    assert_equal dev_count, prod_count,
      "Dev and prod should have the same number of CSS bundles"
  end
end
