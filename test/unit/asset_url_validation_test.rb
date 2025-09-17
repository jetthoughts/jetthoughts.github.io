require_relative "base_page_test"

class AssetUrlValidationTest < BasePageTestCase
  DEFAULT_TEST_HTML_FILE = '404.html'


  def test_svg_icons_use_relative_urls_with_fingerprinting
    # Test that Hugo properly generates fingerprinted asset URLs
    doc = parse_html_file(DEFAULT_TEST_HTML_FILE)

    # Find SVG assets using CSS selectors
    svg_elements = doc.css('img[src*=".svg"], object[data*=".svg"], use[href*=".svg"]')
    svg_urls = svg_elements.map { |el| el['src'] || el['data'] || el['href'] }.compact

    # Should contain relative URLs with fingerprinting
    assert svg_urls.any? { |url| url.match?(/\.\/img\/.*\.[a-f0-9]{32}\.svg/) },
      "Should have fingerprinted SVG assets"

    # Should not contain hardcoded production URLs
    refute svg_urls.any? { |url| url.include?("https://jetthoughts.com/img/icons") },
      "Should not have hardcoded production URLs"
  end

  def test_css_files_use_relative_urls_with_fingerprinting
    doc = parse_html_file(DEFAULT_TEST_HTML_FILE)

    # Find CSS links using CSS selectors
    css_links = doc.css('link[rel="stylesheet"]')
    css_urls = css_links.map { |link| link['href'] }.compact

    # Should contain relative URLs with fingerprinting for CSS
    assert css_urls.any? { |url| url.match?(/\.\/css\/.*\.[a-f0-9]{32}\.css/) },
      "Should have fingerprinted CSS assets"

    # Should not contain hardcoded production CSS URLs
    refute css_urls.any? { |url| url.include?("https://jetthoughts.com/css/") },
      "Should not have hardcoded production URLs"
  end

  def test_javascript_files_use_relative_urls_with_fingerprinting
    doc = parse_html_file(DEFAULT_TEST_HTML_FILE)

    # Find JS scripts using CSS selectors
    js_scripts = doc.css('script[src]')
    js_urls = js_scripts.map { |script| script['src'] }.compact

    # Should contain relative URLs with fingerprinting for JS
    assert js_urls.any? { |url| url.match?(/\.\/js\/.*\.[a-f0-9]{32}\.js/) },
      "Should have fingerprinted JS assets"

    # Should not contain hardcoded production JS URLs
    refute js_urls.any? { |url| url.include?("https://jetthoughts.com/js/") },
      "Should not have hardcoded production URLs"
  end

  def test_assets_have_correct_fingerprints
    # Unit test verifies asset path generation is correct
    doc = parse_html_file(DEFAULT_TEST_HTML_FILE)

    # Collect all asset URLs from various elements
    css_urls = doc.css('link[rel="stylesheet"]').map { |el| el['href'] }
    js_urls = doc.css('script[src]').map { |el| el['src'] }
    img_urls = doc.css('img[src]').map { |el| el['src'] }
    all_urls = (css_urls + js_urls + img_urls).compact

    # Check that we have fingerprinted assets
    fingerprinted = all_urls.select { |url| url.match?(/\.[a-f0-9]{32}\./) }
    assert fingerprinted.any?, "Assets should have fingerprints"
  end

  def test_no_hardcoded_production_urls_in_test_build
    test_files = Dir.glob("#{root_path}/**/*.html")

    test_files.each do |file|
      content = File.read(file)

      # Check for hardcoded jetthoughts.com URLs that should be relative
      hardcoded_assets = content.scan(/https:\/\/jetthoughts\.com\/(css|js|img)\/[^"']+/)

      assert_empty hardcoded_assets,
        "File #{file} contains hardcoded production asset URLs: #{hardcoded_assets.join(', ')}"
    end
  end

  def test_asset_fingerprinting_is_working_correctly
    # Verify that assets have proper fingerprints (32-character hexadecimal)
    doc = parse_html_file(DEFAULT_TEST_HTML_FILE)

    # Collect all asset URLs from various elements
    css_urls = doc.css('link[rel="stylesheet"]').map { |el| el['href'] }
    js_urls = doc.css('script[src]').map { |el| el['src'] }
    img_urls = doc.css('img[src]').map { |el| el['src'] }
    all_urls = (css_urls + js_urls + img_urls).compact

    # Find assets with fingerprints
    fingerprinted_assets = all_urls.select { |url| url.match?(/\.[a-f0-9]{32}\./) }
    assert fingerprinted_assets.any?, "Should find fingerprinted assets"

    fingerprinted_assets.each do |asset|
      # Extract and validate the fingerprint
      if match = asset.match(/\.([a-f0-9]{32})\./)
        fingerprint = match[1]
        assert_equal 32, fingerprint.length, "Fingerprint should be 32 characters"
        assert fingerprint.match?(/^[a-f0-9]+$/), "Fingerprint should be hexadecimal"
      end
    end
  end

end
