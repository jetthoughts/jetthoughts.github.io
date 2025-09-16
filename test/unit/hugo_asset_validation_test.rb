require_relative "base_page_test"

class HugoAssetValidationTest < BasePageTest
  EXPECTED_HOST = "localhost"

  # Asset pattern constants
  SVG_ASSET_PATTERN = /(?:src|href)="([^"]*\.svg[^"]*)"/
  CSS_ASSET_PATTERN = /href="([^"]*\.css[^"]*)"/
  JS_ASSET_PATTERN = /src="([^"]*\.js[^"]*)"/


  def test_svg_assets_use_relative_urls
    doc = parse_html_file("index.html")

    svg_elements = doc.css("img[src*='.svg'], use[href*='.svg']")
    refute_empty svg_elements, "Should have SVG assets"

    svg_elements.each do |element|
      src = element["src"] || element["href"]
      next unless src

      # Should use relative paths or correct localhost
      if src.start_with?("http://", "https://")
        uri = URI.parse(src)
        assert_equal EXPECTED_HOST, uri.host, "SVG should use correct host: #{src}"
      else
        assert src.start_with?("./", "/"), "SVG should use relative path: #{src}"
      end
    end
  end

  def test_css_assets_use_relative_urls
    doc = parse_html_file("index.html")

    css_links = doc.css("link[rel='stylesheet']")
    refute_empty css_links, "Should have CSS links"

    css_links.each do |link|
      href = link["href"]
      next unless href&.include?(".css")

      # Should use relative paths or correct localhost
      if href.start_with?("http://", "https://")
        uri = URI.parse(href)
        assert_equal EXPECTED_HOST, uri.host, "CSS should use correct host: #{href}"
      else
        assert href.start_with?("./", "/"), "CSS should use relative path: #{href}"
      end
    end
  end

  def test_javascript_assets_use_relative_urls
    doc = parse_html_file("index.html")

    js_scripts = doc.css("script[src]")
    refute_empty js_scripts, "Should have JS scripts"

    js_scripts.each do |script|
      src = script["src"]
      next unless src&.include?(".js")

      # Should use relative paths or correct localhost
      if src.start_with?("http://", "https://")
        uri = URI.parse(src)
        assert_equal EXPECTED_HOST, uri.host, "JS should use correct host: #{src}"
      else
        assert src.start_with?("./", "/"), "JS should use relative path: #{src}"
      end
    end
  end

  def test_image_assets_use_relative_urls
    doc = parse_html_file("index.html")

    img_elements = doc.css("img[src*='.jpg'], img[src*='.png'], img[src*='.gif'], img[src*='.webp']")

    if img_elements.any?
      img_elements.each do |img|
        src = img["src"]
        next unless src

        # Should use relative paths or correct localhost
        if src.start_with?("http://", "https://")
          uri = URI.parse(src)
          assert_equal EXPECTED_HOST, uri.host, "Image should use correct host: #{src}"
        else
          assert src.start_with?("./", "/"), "Image should use relative path: #{src}"
        end
      end
    end
  end

  def test_no_hardcoded_production_urls
    doc = parse_html_file("index.html")

    # Check all asset links for hardcoded production URLs
    assets = doc.css("link[href], script[src], img[src]")

    hardcoded_assets = assets.select do |asset|
      url = asset["href"] || asset["src"]
      url&.include?("jetthoughts.com") && (url.include?("/css/") || url.include?("/js/") || url.include?("/img/"))
    end

    assert_empty hardcoded_assets.map { |a| a["href"] || a["src"] },
      "Should not have hardcoded production asset URLs"
  end
end