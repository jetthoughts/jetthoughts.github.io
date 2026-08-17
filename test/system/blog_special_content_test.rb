# frozen_string_literal: true

require "application_system_test_case"

# Guards the CSS surfaces only blog posts exercise (Phase 0 / P0.1 of the CSS
# maintainability plan): Mermaid diagram containers, Chroma code highlighting
# (Dracula inline styles), raw inline-style HTML, and the youtube embed.
# One representative post per surface. Mermaid is captured AFTER render
# (wait for div.mermaid svg) so the diagram itself is verified; remaining
# volatile regions (external iframe, responsive images) stay skipped.

# Order matches the fence order in content/blog/codeblock-styles-fixture/index.md.
module CodeblockFixtureSections
  SECTIONS = {
    "text" => 0, "md" => 1, "ruby" => 2, "python" => 3,
    "js" => 4, "html" => 5, "bare" => 6, "indented" => 7
  }.freeze

  def codeblock_fixture_sections
    SECTIONS
  end

  # The mermaid pixels depend on Caveat; fonts load lazily, so poll until the
  # font is actually usable instead of asserting a race.
  def wait_for_caveat(timeout: 10)
    deadline = Time.now + timeout
    page.evaluate_script('document.fonts.load("20px Caveat")')
    until page.evaluate_script('document.fonts.check("20px Caveat")')
      raise "Caveat not loaded within #{timeout}s - capture would use a fallback font" if Time.now > deadline

      sleep 0.2
    end
  end
end

class BlogSpecialContentDesktopTest < ApplicationSystemTestCase
  include CodeblockFixtureSections

  def setup
    Capybara.current_driver = :desktop_chrome
    screenshot_section "desktop"
    super
  end

  def test_mermaid_post
    visit "/blog/hidden-cost-poor-development-vendor-management-fix/"

    # Pre-rendered pages ship the <svg> in the HTML (data-prerendered);
    # runtime pages get it only after fonts load and mermaid.run() marks the
    # node data-processed. Either way the pixels depend on Caveat, so wait
    # for the font itself before capturing.
    assert_css "div.mermaid[data-processed] svg", minimum: 1, wait: 10
    wait_for_caveat

    scroll_to(find("div.mermaid"))
    assert_stable_screenshot "blog/special/mermaid_post", tolerance: 0.03,
      skip_area: %w[picture img]
  end

  def test_code_highlight_post
    visit "/blog/stimulus-keyboard-event-filter/"

    assert_css "pre", minimum: 3, wait: 5

    assert_stable_screenshot "blog/special/code_highlight_post", tolerance: 0.03,
      skip_area: %w[picture img]
  end

  def test_codeblock_language_styles
    visit "/blog/codeblock-styles-fixture/"

    assert_css "pre", minimum: 8, wait: 5

    codeblock_fixture_sections.each do |name, index|
      scroll_to all("pre")[index]
      assert_stable_screenshot "blog/special/codeblocks/#{name}", tolerance: 0.03,
        skip_area: %w[picture img]
    end
  end

  def test_inline_style_post
    visit "/blog/revise-your-stylesheets-part-1-color-scheme-webdev-css/"

    assert_stable_screenshot "blog/special/inline_style_post", tolerance: 0.03,
      skip_area: %w[picture img]
  end

  def test_youtube_embed_post
    visit "/blog/how-find-your-next-startup-idea-lessons-from-y-combinator-management/"

    assert_stable_screenshot "blog/special/youtube_post", tolerance: 0.03,
      skip_area: %w[iframe picture img]
  end
end

class BlogSpecialContentMobileTest < ApplicationSystemTestCase
  include CodeblockFixtureSections

  def setup
    Capybara.current_driver = :mobile_chrome
    screenshot_section "mobile"
    super
  end

  def test_mermaid_post
    visit "/blog/hidden-cost-poor-development-vendor-management-fix/"

    # Pre-rendered pages ship the <svg> in the HTML (data-prerendered);
    # runtime pages get it only after fonts load and mermaid.run() marks the
    # node data-processed. Either way the pixels depend on Caveat, so wait
    # for the font itself before capturing.
    assert_css "div.mermaid[data-processed] svg", minimum: 1, wait: 10
    wait_for_caveat

    scroll_to(find("div.mermaid"))
    assert_stable_screenshot "blog/special/mermaid_post", tolerance: 0.03,
      skip_area: %w[picture img]
  end

  def test_code_highlight_post
    visit "/blog/stimulus-keyboard-event-filter/"

    assert_css "pre", minimum: 3, wait: 5

    assert_stable_screenshot "blog/special/code_highlight_post", tolerance: 0.03,
      skip_area: %w[picture img]
  end

  def test_codeblock_language_styles
    visit "/blog/codeblock-styles-fixture/"

    assert_css "pre", minimum: 8, wait: 5

    codeblock_fixture_sections.each do |name, index|
      scroll_to all("pre")[index]
      assert_stable_screenshot "blog/special/codeblocks/#{name}", tolerance: 0.03,
        skip_area: %w[picture img]
    end
  end
end
