require "base_page_test_case"

class DiagramRenderingTest < BasePageTestCase
  # Unit tests for diagram rendering functionality (Mermaid support)
  # Tests rendered HTML output from public-test directory (no server required)

  def test_mermaid_diagram_content_preserved
    # Test that a page with mermaid diagram renders the content correctly
    doc = parse_html_file("test/components/diagram/index.html")

    # Should contain the diagram content in mermaid divs
    mermaid_divs = doc.css("div.mermaid")
    assert mermaid_divs.any?, "Should have div elements with mermaid class"

    # Check that the content is preserved
    flowchart_content = mermaid_divs.any? { |div| div.text.include?("graph TD") }
    sequence_content = mermaid_divs.any? { |div| div.text.include?("sequenceDiagram") }

    assert flowchart_content, "Should contain flowchart diagram content"
    assert sequence_content, "Should contain sequence diagram content"
  end

  def test_mermaid_javascript_library_included
    # Test page with diagram
    doc = parse_html_file("test/components/diagram/index.html")

    # Should include Mermaid JS library when diagrams are present
    scripts = doc.css("script[src]")
    has_mermaid_js = scripts.any? { |script| script["src"]&.include?("mermaid") }

    assert has_mermaid_js, "Should include Mermaid.js library for pages with diagrams"

    # Check for mermaid initialization script
    inline_scripts = doc.css("script").select { |s| s.text.include?("mermaid.initialize") }
    assert inline_scripts.any?, "Should have Mermaid initialization script"
  end

  # CSS test removed - simplified Mermaid implementation doesn't require separate CSS
  # The Mermaid library includes its own styling

  def test_mermaid_div_structure
    doc = parse_html_file("test/components/diagram/index.html")

    # Check for properly formatted mermaid divs
    mermaid_divs = doc.css("div.mermaid")
    assert mermaid_divs.count >= 2, "Should have at least 2 Mermaid div elements"

    # Each div should contain diagram content directly
    mermaid_divs.each do |div|
      assert div.text.strip.length > 0, "Mermaid div should contain diagram content"
    end
  end

  # Conversion logic test removed - simplified Mermaid implementation renders divs directly
  # No JavaScript conversion needed since Hugo outputs div.mermaid elements directly

  def test_page_without_diagrams_no_mermaid_scripts
    # Test a page without diagrams shouldn't load Mermaid
    doc = parse_html_file("index.html")

    scripts = doc.css("script[src]")
    has_mermaid_js = scripts.any? { |script| script["src"]&.include?("mermaid") }

    refute has_mermaid_js, "Should not include Mermaid.js on pages without diagrams"
  end

  def test_mermaid_accessibility_attributes
    doc = parse_html_file("test/components/diagram/index.html")

    # Check that mermaid divs are accessible (Mermaid library handles SVG accessibility)
    mermaid_divs = doc.css("div.mermaid")
    assert mermaid_divs.any?, "Should have mermaid divs for accessibility testing"

    # Basic accessibility check - divs should exist and be identifiable
    mermaid_divs.each do |div|
      assert_equal "mermaid", div["class"], "Should have mermaid class for identification"
    end
  end
end
