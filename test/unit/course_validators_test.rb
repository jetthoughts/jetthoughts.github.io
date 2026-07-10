# frozen_string_literal: true

require_relative "../test_helper"
require_relative "../../lib/course_validators"

class CourseValidatorsTest < Minitest::Test
  def setup
    @tmpdir = Dir.mktmpdir("course_validators_test")
    @orig_course_dir = CourseValidators::COURSE_DIR
    @orig_all_blog_dir = CourseValidators::ALL_BLOG_DIR
    @orig_yaml_path = CourseValidators::YAML_PATH

    # Override constants for testing
    silence_warnings do
      CourseValidators.const_set(:COURSE_DIR, "#{@tmpdir}/content/blog")
      CourseValidators.const_set(:ALL_BLOG_DIR, "#{@tmpdir}/content/blog")
      CourseValidators.const_set(:YAML_PATH, "#{@tmpdir}/data/course_sequence.yaml")
    end

    FileUtils.mkdir_p("#{@tmpdir}/data")
    FileUtils.mkdir_p("#{@tmpdir}/content/blog")
  end

  def teardown
    FileUtils.rm_rf(@tmpdir)
    silence_warnings do
      CourseValidators.const_set(:COURSE_DIR, @orig_course_dir)
      CourseValidators.const_set(:ALL_BLOG_DIR, @orig_all_blog_dir)
      CourseValidators.const_set(:YAML_PATH, @orig_yaml_path)
    end
  end

  # ── Helper: write a course chapter ───────────────────────────────────────

  def write_course_chapter(slug:, title:, og_title: nil, body: "", course_chapter: true, extra_frontmatter: {})
    dir = "#{@tmpdir}/content/blog/#{slug}"
    FileUtils.mkdir_p(dir)

    fm = {
      "title" => title,
      "course_chapter" => course_chapter,
      "slug" => slug
    }.merge(extra_frontmatter)

    if og_title
      fm["metatags"] ||= {}
      fm["metatags"]["og_title"] = og_title
    end

    yaml_fm = YAML.dump(fm)
    content = "---\n#{yaml_fm}---\n#{body}"
    File.write("#{dir}/index.md", content)
  end

  def write_yaml(entries)
    data = { "sequence" => entries }
    FileUtils.mkdir_p("#{@tmpdir}/data")
    File.write("#{@tmpdir}/data/course_sequence.yaml", YAML.dump(data))
  end

  def write_blog_post(slug:)
    dir = "#{@tmpdir}/content/blog/#{slug}"
    FileUtils.mkdir_p(dir)
    File.write("#{dir}/index.md", "---\ntitle: \"#{slug}\"\ndate: 2026-01-01\n---\n\nRegular post.\n")
  end

  def silence_warnings
    old_verbose = $VERBOSE
    $VERBOSE = nil
    yield
  ensure
    $VERBOSE = old_verbose
  end

  # ── Validator 1: Chapter-number consistency ─────────────────────────────

  def test_chapter_number_consistency_all_valid
    write_yaml([
      { "slug" => "ch1", "title" => "1.1 · Test Chapter", "module" => "Chapter 1.1", "goal" => "Test" }
    ])
    write_course_chapter(slug: "ch1", title: "1.1 · Test Chapter",
      body: "See Chapter 1.1 for details. Also Chapter 1.1 has more info.\n")

    results = CourseValidators.run_all
    result = results.find { |r| r.name == "chapter-number-consistency" }

    assert result.passed, "Expected no chapter-number violations, got: #{result.violations.inspect}"
  end

  def test_chapter_number_consistency_invalid_ref
    write_yaml([
      { "slug" => "ch1", "title" => "1.1 · Test Chapter", "module" => "Chapter 1.1", "goal" => "Test" }
    ])
    write_course_chapter(slug: "ch1", title: "1.1 · Test Chapter",
      body: "See Chapter 9.9 for details.\n")

    results = CourseValidators.run_all
    result = results.find { |r| r.name == "chapter-number-consistency" }

    refute result.passed, "Expected a violation for invalid Chapter 9.9"
    assert result.violations.any? { |v| v.include?("9.9") }
  end

  def test_chapter_number_consistency_skips_non_course_posts
    write_yaml([
      { "slug" => "ch1", "title" => "1.1 · Test Chapter", "module" => "Chapter 1.1", "goal" => "Test" }
    ])
    # This post has course_chapter: false - should not be scanned
    write_course_chapter(slug: "regular-post", title: "Regular Post",
      course_chapter: false, body: "See Chapter 9.9 for details.\n")

    results = CourseValidators.run_all
    result = results.find { |r| r.name == "chapter-number-consistency" }

    assert result.passed, "Non-course posts should not trigger chapter-number violations"
  end

  def test_chapter_number_consistency_svg_check
    write_yaml([
      { "slug" => "ch1", "title" => "1.1 · Test Chapter", "module" => "Chapter 1.1", "goal" => "Test" }
    ])

    dir = "#{@tmpdir}/content/blog/ch1"
    FileUtils.mkdir_p(dir)
    write_course_chapter(slug: "ch1", title: "1.1 · Test Chapter", body: "Some content.\n")
    File.write("#{dir}/diagram.svg", <<~SVG)
      <svg xmlns="http://www.w3.org/2000/svg">
        <text>Chapter 9.9 reference in SVG</text>
      </svg>
    SVG

    results = CourseValidators.run_all
    result = results.find { |r| r.name == "chapter-number-consistency" }

    refute result.passed
    assert result.violations.any? { |v| v.include?("9.9") && v.include?(".svg") }
  end

  def test_chapter_number_consistency_module_callout_wrong
    write_yaml([
      { "slug" => "ch1", "title" => "1.1 · Test Chapter", "module" => "Chapter 1.1", "goal" => "Test" }
    ])
    write_course_chapter(slug: "ch1", title: "1.1 · Test Chapter",
      body: "> **Module 2 · Step 1 of 3** · Course.\n")

    results = CourseValidators.run_all
    result = results.find { |r| r.name == "chapter-number-consistency" }

    refute result.passed
    assert result.violations.any? { |v| v.include?("Module 2") }
  end

  # ── Validator 2: Title-YAML match ────────────────────────────────────────

  def test_title_yaml_match_valid
    write_yaml([
      { "slug" => "ch1", "title" => "1.1 · Form Your Hypothesis", "module" => "Chapter 1.1", "goal" => "Test" }
    ])
    write_course_chapter(slug: "ch1", title: "1.1 · Form Your Hypothesis - Extended",
      og_title: "1.1 · Form Your Hypothesis - Extended",
      body: "> **Module 1 · Step 1 of 3** · Course.\n")

    results = CourseValidators.run_all
    result = results.find { |r| r.name == "title-yaml-match" }

    assert result.passed, "Expected no title-match violations, got: #{result.violations.inspect}"
  end

  def test_title_yaml_match_title_mismatch
    write_yaml([
      { "slug" => "ch1", "title" => "1.1 · Form Your Hypothesis", "module" => "Chapter 1.1", "goal" => "Test" }
    ])
    write_course_chapter(slug: "ch1", title: "2.1 · Different Chapter",
      body: "> **Module 1 · Step 1 of 3** · Course.\n")

    results = CourseValidators.run_all
    result = results.find { |r| r.name == "title-yaml-match" }

    refute result.passed
    assert result.violations.any? { |v| v.include?("does not start with") }
  end

  def test_title_yaml_match_og_title_mismatch
    write_yaml([
      { "slug" => "ch1", "title" => "1.1 · Form Your Hypothesis", "module" => "Chapter 1.1", "goal" => "Test" }
    ])
    write_course_chapter(slug: "ch1", title: "1.1 · Form Your Hypothesis",
      og_title: "2.1 · Different OG Title",
      body: "> **Module 1 · Step 1 of 3** · Course.\n")

    results = CourseValidators.run_all
    result = results.find { |r| r.name == "title-yaml-match" }

    refute result.passed
    assert result.violations.any? { |v| v.include?("og_title") && v.include?("does not start with") }
  end

  def test_title_yaml_match_callout_step_mismatch
    write_yaml([
      { "slug" => "ch1", "title" => "1.1 · Form Your Hypothesis", "module" => "Chapter 1.1", "goal" => "Test" }
    ])
    write_course_chapter(slug: "ch1", title: "1.1 · Form Your Hypothesis",
      body: "> **Module 1 · Step 5 of 3** · Course.\n")

    results = CourseValidators.run_all
    result = results.find { |r| r.name == "title-yaml-match" }

    refute result.passed
    assert result.violations.any? { |v| v.include?("Step 5") }
  end

  # ── Validator 3: Internal-link existence ─────────────────────────────────

  def test_internal_links_all_valid
    write_yaml([
      { "slug" => "ch1", "title" => "1.1 · Test", "module" => "Chapter 1.1", "goal" => "Test" }
    ])
    write_blog_post(slug: "existing-post")
    write_course_chapter(slug: "ch1", title: "1.1 · Test",
      body: "Check out this [post](/blog/existing-post/).\n")

    results = CourseValidators.run_all
    result = results.find { |r| r.name == "internal-link-existence" }

    assert result.passed, "Expected no link violations, got: #{result.violations.inspect}"
  end

  def test_internal_links_missing_target
    write_yaml([
      { "slug" => "ch1", "title" => "1.1 · Test", "module" => "Chapter 1.1", "goal" => "Test" }
    ])
    write_course_chapter(slug: "ch1", title: "1.1 · Test",
      body: "Check out this [post](/blog/nonexistent-post/).\n")

    results = CourseValidators.run_all
    result = results.find { |r| r.name == "internal-link-existence" }

    refute result.passed
    assert result.violations.any? { |v| v.include?("nonexistent-post") }
  end

  def test_internal_links_skips_external_urls
    write_yaml([
      { "slug" => "ch1", "title" => "1.1 · Test", "module" => "Chapter 1.1", "goal" => "Test" }
    ])
    write_course_chapter(slug: "ch1", title: "1.1 · Test",
      body: "External [link](https://example.com) and [mailto](mailto:test@test.com).\n")

    results = CourseValidators.run_all
    result = results.find { |r| r.name == "internal-link-existence" }

    assert result.passed, "External links should not trigger violations"
  end

  def test_internal_links_multiple_course_chapters
    write_yaml([
      { "slug" => "ch1", "title" => "1.1 · Test", "module" => "Chapter 1.1", "goal" => "Test" },
      { "slug" => "ch2", "title" => "1.2 · Test", "module" => "Chapter 1.2", "goal" => "Test" }
    ])
    write_blog_post(slug: "existing-post")
    write_course_chapter(slug: "ch1", title: "1.1 · Test",
      body: "See [ch1](/blog/existing-post/) and [ch2](/blog/nonexistent-slug/).\n")
    write_course_chapter(slug: "ch2", title: "1.2 · Test",
      body: "See [valid](/blog/existing-post/).\n")

    results = CourseValidators.run_all
    result = results.find { |r| r.name == "internal-link-existence" }

    refute result.passed
    assert result.violations.any? { |v| v.include?("nonexistent-slug") }
  end

  # ── Validator 4: Table-width ─────────────────────────────────────────────

  def test_table_width_small_tables_pass
    write_yaml([
      { "slug" => "ch1", "title" => "1.1 · Test", "module" => "Chapter 1.1", "goal" => "Test" }
    ])
    write_course_chapter(slug: "ch1", title: "1.1 · Test", body: <<~BODY)
      | Small | Table |
      |-------|-------|
      | a     | b     |
    BODY

    results = CourseValidators.run_all
    result = results.find { |r| r.name == "table-width" }

    assert result.passed, "2-column tables should not trigger violations"
  end

  def test_table_width_five_columns_fails
    write_yaml([
      { "slug" => "ch1", "title" => "1.1 · Test", "module" => "Chapter 1.1", "goal" => "Test" }
    ])
    write_course_chapter(slug: "ch1", title: "1.1 · Test", body: <<~BODY)
      | Col1 | Col2 | Col3 | Col4 | Col5 |
      |------|------|------|------|------|
      | a    | b    | c    | d    | e    |
    BODY

    results = CourseValidators.run_all
    result = results.find { |r| r.name == "table-width" }

    refute result.passed, "5-column table should trigger violation"
    assert result.violations.any? { |v| v.include?("5 columns") }
  end

  def test_table_width_three_and_four_columns_pass
    write_yaml([
      { "slug" => "ch1", "title" => "1.1 · Test", "module" => "Chapter 1.1", "goal" => "Test" }
    ])
    write_course_chapter(slug: "ch1", title: "1.1 · Test", body: <<~BODY)
      | 3-col | table | here |
      |-------|-------|------|
      | x     | y     | z    |

      | 4-col | wider | table | here |
      |-------|-------|-------|------|
      | a     | b     | c     | d    |
    BODY

    results = CourseValidators.run_all
    result = results.find { |r| r.name == "table-width" }

    assert result.passed, "3 and 4 column tables should pass"
  end

  def test_table_width_non_course_posts_skipped
    write_yaml([
      { "slug" => "ch1", "title" => "1.1 · Test", "module" => "Chapter 1.1", "goal" => "Test" }
    ])
    write_course_chapter(slug: "regular", title: "Regular",
      course_chapter: false, body: <<~BODY)
        | 5-col | table | should | be | skipped |
        |-------|-------|--------|-----|---------|
        | a     | b     | c      | d   | e       |
    BODY

    results = CourseValidators.run_all
    result = results.find { |r| r.name == "table-width" }

    assert result.passed, "Non-course posts should be excluded from table-width check"
  end

  # ── Integration: all validators run together ────────────────────────────

  def test_run_all_returns_eight_results
    write_yaml([
      { "slug" => "ch1", "title" => "1.1 · Test", "module" => "Chapter 1.1", "goal" => "Test" }
    ])
    write_course_chapter(slug: "ch1", title: "1.1 · Test Chapter",
      og_title: "1.1 · Test Chapter", body: "Content.\n")

    results = CourseValidators.run_all

    assert_equal 8, results.length
    names = results.map(&:name)
    assert_includes names, "chapter-number-consistency"
    assert_includes names, "title-yaml-match"
    assert_includes names, "internal-link-existence"
    assert_includes names, "table-width"
    assert_includes names, "disclaimer-consistency"
    assert_includes names, "no-em-dash"
    assert_includes names, "year-stamp-fabrication"
  end

  def test_run_all_with_no_course_chapters
    write_yaml([])
    results = CourseValidators.run_all

    assert_equal 8, results.length
    results.each do |r|
      assert r.passed, "All validators should pass when no course chapters exist: #{r.name} failed"
    end
  end

  # ── Edge cases ──────────────────────────────────────────────────────────

  def test_missing_yaml_file_does_not_crash
    # Remove the YAML file so it doesn't exist
    FileUtils.rm_rf("#{@tmpdir}/data")
    write_course_chapter(slug: "ch1", title: "1.1 · Test", body: "Content.\n")

    results = CourseValidators.run_all

    assert_equal 8, results.length
    # Should not crash - just produce empty violations
  end

  def test_internal_links_handles_mixed_urls
    write_yaml([
      { "slug" => "ch1", "title" => "1.1 · Test", "module" => "Chapter 1.1", "goal" => "Test" }
    ])
    write_blog_post(slug: "real-post")
    write_course_chapter(slug: "ch1", title: "1.1 · Test", body: <<~BODY)
      Valid [link](/blog/real-post/), invalid [link](/blog/missing-post/),
      and external [link](https://example.com).
    BODY

    results = CourseValidators.run_all
    result = results.find { |r| r.name == "internal-link-existence" }

    refute result.passed, "Should flag missing-post"
    assert result.violations.any? { |v| v.include?("missing-post") }
    refute result.violations.any? { |v| v.include?("real-post") }
    refute result.violations.any? { |v| v.include?("example.com") }
  end

  # ── Validator 5: disclaimer consistency ──────────────────────────────────

  def test_disclaimer_consistency_all_chapters_have_it_passes
    write_course_chapter(slug: "ch-a", title: "A", body: "Founder anecdotes use anonymized names.\n")
    write_course_chapter(slug: "ch-b", title: "B", body: "Also uses anonymized names here.\n")

    result = CourseValidators.run_all.find { |r| r.name == "disclaimer-consistency" }
    assert result.passed, "All-have should pass, got: #{result.violations.inspect}"
  end

  def test_disclaimer_consistency_none_have_it_passes
    write_course_chapter(slug: "ch-a", title: "A", body: "Plain body.\n")
    write_course_chapter(slug: "ch-b", title: "B", body: "Another plain body.\n")

    result = CourseValidators.run_all.find { |r| r.name == "disclaimer-consistency" }
    assert result.passed, "None-have should pass, got: #{result.violations.inspect}"
  end

  def test_disclaimer_consistency_some_have_it_fails
    write_course_chapter(slug: "ch-a", title: "A", body: "Uses anonymized names here.\n")
    write_course_chapter(slug: "ch-b", title: "B", body: "Plain body, no disclaimer.\n")

    result = CourseValidators.run_all.find { |r| r.name == "disclaimer-consistency" }
    refute result.passed, "Some-have should fail (inconsistent)"
    assert result.violations.any? { |v| v.include?("ch-a") }
  end

  # ── Validator 6: no em-dash in content ───────────────────────────────────

  def test_em_dash_flagged_in_body
    write_course_chapter(slug: "ch-a", title: "A", body: "A sentence — with an em-dash.\n")

    result = CourseValidators.run_all.find { |r| r.name == "no-em-dash" }
    refute result.passed, "Em-dash in body should fail"
    assert result.violations.any? { |v| v.include?("ch-a") }
  end

  def test_em_dash_ignored_inside_code_fence
    body = "Use a hyphen - like this.\n\n```\nlet x = a — b\n```\n"
    write_course_chapter(slug: "ch-a", title: "A", body: body)

    result = CourseValidators.run_all.find { |r| r.name == "no-em-dash" }
    assert result.passed, "Em-dash inside a code fence should be ignored, got: #{result.violations.inspect}"
  end

  # ── Validator 7: year-stamp client-cohort fabrication ────────────────────

  def test_year_stamp_cohort_phrase_flagged
    write_course_chapter(slug: "ch-a", title: "A", body: "Most founders we joined in 2026 skipped this.\n")

    result = CourseValidators.run_all.find { |r| r.name == "year-stamp-fabrication" }
    refute result.passed, "'founders we joined in 2026' should fail"
    assert result.violations.any? { |v| v.include?("ch-a") }
  end

  def test_year_stamp_a_year_example_flagged
    write_course_chapter(slug: "ch-a", title: "A", body: "A 2026 example from a founder.\n")

    result = CourseValidators.run_all.find { |r| r.name == "year-stamp-fabrication" }
    refute result.passed, "'A 2026 example' should fail"
  end

  def test_year_stamp_legitimate_date_not_flagged
    write_course_chapter(slug: "ch-a", title: "A", body: "Jake Knapp published Click in April 2025 after twenty years.\n")

    result = CourseValidators.run_all.find { |r| r.name == "year-stamp-fabrication" }
    assert result.passed, "Legitimate publication date should NOT be flagged, got: #{result.violations.inspect}"
  end

  def test_year_stamp_month_year_cohort_flagged
    write_course_chapter(slug: "ch-a", title: "A", body: "A founder we worked with in February 2026 ran five interviews.\n")

    result = CourseValidators.run_all.find { |r| r.name == "year-stamp-fabrication" }
    refute result.passed, "'A founder we worked with in February 2026' should fail"
    assert result.violations.any? { |v| v.include?("ch-a") }
  end

  def test_year_stamp_rescue_we_joined_month_year_flagged
    write_course_chapter(slug: "ch-a", title: "A", body: "A B2B SaaS rescue we joined in April 2026 had cleared four paid pilots.\n")

    result = CourseValidators.run_all.find { |r| r.name == "year-stamp-fabrication" }
    refute result.passed, "'rescue we joined in April 2026' should fail"
  end
end
