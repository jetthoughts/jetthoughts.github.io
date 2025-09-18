# frozen_string_literal: true

require "application_system_test_case"

class DiagramComponentTest < ApplicationSystemTestCase
  def setup
    # Now using desktop_chrome driver to test if browser crashes are fixed
    Capybara.current_driver = :desktop_chrome
    super
  end

  def test_diagram_content_page
    visit "/test/components/diagram/"

    assert_text "Test Page for Diagram Rendering"

    assert_css "div.mermaid", minimum: 2, wait: 1
    assert_css "[id^=mermaid-]"

    assert_stable_screenshot "components/diagram", tolerance: 0.08
  end
end
