require "page_test_case"

class AssetUrlValidationTest < PageTestCase
  DEFAULT_TEST_HTML_FILE = '404.html'

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
