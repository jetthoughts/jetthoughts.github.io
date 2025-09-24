# frozen_string_literal: true

require "application_system_test_case"

class DiagramComponentTest < ApplicationSystemTestCase
  def setup
    skip "Diagram component is not yet implemented"
    Capybara.current_driver = :desktop_chrome
    super
  end

  def test_diagram_content_page
    visit "/test/components/diagram/"

    # Wait for page to load
    assert_text "Test Page for Diagram Rendering"

    # Verify mermaid diagrams are rendered as div elements
    assert_css "div.mermaid", minimum: 2, wait: 3

    # Verify essential diagram elements are present (text nodes in the rendered diagrams)
    assert_text "Start"  # From the flowchart
    assert_text "User"   # From the sequence diagram

    # Take screenshot with higher tolerance for dynamic SVG rendering
    assert_stable_screenshot "components/diagram", tolerance: 0.08
  end
end
