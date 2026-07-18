# frozen_string_literal: true

require "application_system_test_case"

# Guards the CSS surfaces only blog posts exercise (Phase 0 / P0.1 of the CSS
# maintainability plan): Mermaid diagram containers, Chroma code highlighting
# (Dracula inline styles), raw inline-style HTML, and the youtube embed.
# One representative post per surface. Mermaid is captured AFTER render
# (wait for div.mermaid svg) so the diagram itself is verified; remaining
# volatile regions (external iframe, responsive images) stay skipped.
class BlogSpecialContentDesktopTest < ApplicationSystemTestCase
  def setup
    Capybara.current_driver = :desktop_chrome
    screenshot_section "desktop"
    super
  end

  def test_mermaid_post
    visit "/blog/hidden-cost-poor-development-vendor-management-fix/"

    # The <svg> child appears only after document.fonts.ready -> mermaid.run()
    assert_css "div.mermaid svg", minimum: 1, wait: 10

    scroll_to(find("div.mermaid"))
    assert_stable_screenshot "blog/special/mermaid_post", tolerance: 0.03,
      skip_area: %w[picture img], stability_time_limit: 1
  end

  def test_code_highlight_post
    visit "/blog/stimulus-keyboard-event-filter/"

    assert_css "pre", minimum: 3, wait: 5

    assert_stable_screenshot "blog/special/code_highlight_post", tolerance: 0.03,
      skip_area: %w[picture img], stability_time_limit: 1
  end

  def test_inline_style_post
    visit "/blog/revise-your-stylesheets-part-1-color-scheme-webdev-css/"

    assert_stable_screenshot "blog/special/inline_style_post", tolerance: 0.03,
      skip_area: %w[picture img], stability_time_limit: 1
  end

  def test_youtube_embed_post
    visit "/blog/how-find-your-next-startup-idea-lessons-from-y-combinator-management/"

    assert_stable_screenshot "blog/special/youtube_post", tolerance: 0.03,
      skip_area: %w[iframe picture img], stability_time_limit: 1
  end
end

class BlogSpecialContentMobileTest < ApplicationSystemTestCase
  def setup
    Capybara.current_driver = :mobile_chrome
    screenshot_section "mobile"
    super
  end

  def test_mermaid_post
    visit "/blog/hidden-cost-poor-development-vendor-management-fix/"

    # The <svg> child appears only after document.fonts.ready -> mermaid.run()
    assert_css "div.mermaid svg", minimum: 1, wait: 10

    scroll_to(find("div.mermaid"))
    assert_stable_screenshot "blog/special/mermaid_post", tolerance: 0.03,
      skip_area: %w[picture img], stability_time_limit: 1
  end

  def test_code_highlight_post
    visit "/blog/stimulus-keyboard-event-filter/"

    assert_css "pre", minimum: 3, wait: 5

    assert_stable_screenshot "blog/special/code_highlight_post", tolerance: 0.03,
      skip_area: %w[picture img], stability_time_limit: 1
  end
end
