# frozen_string_literal: true

require "application_system_test_case"

class HugoShortcodesTest < ApplicationSystemTestCase
  # Test common Hugo shortcodes and partials functionality
  
  def test_svg_partial_rendering
    # Visit any page that should have SVG partials
    visit "/about-us"
    
    # Check for SVG elements in the page
    assert_selector "svg", minimum: 1,
      message: "Page should have at least one SVG element"
    
    # Check SVG logo in header
    within "header" do
      assert_selector "svg", 
        message: "Header should contain SVG logo"
      assert_selector "a[title*='JetThoughts']",
        message: "Logo should have proper title attribute"
    end
  end
  
  def test_navigation_partial_structure
    visit "/"
    
    # Check main navigation structure
    within "nav.navigation" do
      assert_selector "ul.list[role='menubar']",
        message: "Navigation should have proper ARIA menubar structure"
      assert_selector "li.item[role='menuitem']", minimum: 1,
        message: "Should have navigation menu items"
      
      # Check for submenu functionality
      if has_selector?("li[aria-haspopup='true']")
        assert_selector "ul.sub-menu[role='menu']",
          message: "Submenus should have proper ARIA menu structure"
      end
    end
    
    # Check mobile menu functionality
    assert_selector ".menu-opener",
      message: "Should have mobile menu opener"
    assert_selector ".menu-close",
      message: "Should have mobile menu close button"
  end
  
  def test_footer_partial_content
    visit "/"
    
    within "footer" do
      # Check for essential footer content
      assert_selector "a[href*='mailto:']",
        message: "Footer should have email contact link"
      assert_selector "a[href*='tel:']",
        message: "Footer should have phone contact link"
      
      # Check for social media links
      assert_selector "nav[aria-label*='Social'] a", minimum: 1,
        message: "Should have social media navigation links"
      
      # Check for service navigation
      assert_selector "nav[aria-label*='Services']",
        message: "Should have services navigation in footer"
      
      # Copyright notice
      assert_text /© \d{4} JetThoughts/,
        "Should have current year copyright notice"
    end
  end
  
  def test_schema_markup_partials
    visit "/"
    
    # Check for structured data (JSON-LD)
    json_ld_scripts = all('script[type="application/ld+json"]')
    assert json_ld_scripts.count >= 1,
      "Should have at least one JSON-LD structured data script"
    
    # Validate JSON-LD content
    json_ld_scripts.each_with_index do |script, index|
      json_content = script.text
      
      # Should be valid JSON
      begin
        parsed_json = JSON.parse(json_content)
        assert parsed_json.is_a?(Hash) || parsed_json.is_a?(Array),
          "JSON-LD script #{index + 1} should contain valid JSON object or array"
        
        # Should have @context and @type for schema.org
        if parsed_json.is_a?(Hash)
          assert parsed_json["@context"] || parsed_json.dig("@graph", 0, "@context"),
            "JSON-LD should include @context"
          assert parsed_json["@type"] || parsed_json.dig("@graph", 0, "@type"),
            "JSON-LD should include @type"
        end
      rescue JSON::ParserError
        flunk "JSON-LD script #{index + 1} contains invalid JSON"
      end
    end
  end
  
  def test_seo_meta_tags_partial
    visit "/"
    
    within "head" do
      # Essential SEO meta tags
      assert_selector "title", 
        message: "Should have title tag"
      assert_selector "meta[name='description']",
        message: "Should have meta description"
      assert_selector "link[rel='canonical']",
        message: "Should have canonical link"
      
      # Open Graph tags
      assert_selector "meta[property='og:title']",
        message: "Should have Open Graph title"
      assert_selector "meta[property='og:description']",
        message: "Should have Open Graph description"
      assert_selector "meta[property='og:type']",
        message: "Should have Open Graph type"
      assert_selector "meta[property='og:url']",
        message: "Should have Open Graph URL"
      
      # Twitter Card tags
      assert_selector "meta[name='twitter:card']",
        message: "Should have Twitter Card type"
      assert_selector "meta[name='twitter:title']",
        message: "Should have Twitter title"
      
      # Viewport and responsive tags
      assert_selector "meta[name='viewport']",
        message: "Should have viewport meta tag"
    end
  end
  
  def test_css_asset_pipeline_partial
    visit "/"
    
    # Check for CSS files loaded through asset pipeline
    css_links = all("link[rel='stylesheet']")
    assert css_links.count >= 1,
      "Should have at least one CSS file loaded"
    
    css_links.each do |link|
      href = link[:href]
      
      # CSS files should have cache-busting hashes
      assert href.match?(/\.min\.[a-f0-9]+\.css$/),
        "CSS file '#{href}' should have minified version with hash"
      
      # Should have integrity attribute for security
      if href.start_with?("http") == false # Local CSS files
        assert link[:integrity].present?,
          "Local CSS file should have integrity hash"
      end
    end
  end
  
  def test_javascript_asset_pipeline_partial
    visit "/"
    
    # Check for JavaScript files
    js_scripts = all("script[src]")
    
    js_scripts.each do |script|
      src = script[:src]
      
      # Skip external scripts (GTM, etc.)
      next if src.start_with?("http")
      
      # Local JS should have cache-busting hashes
      if src.include?("_site") || src.include?(".min.")
        assert src.match?(/\.[a-f0-9]+\.js$/),
          "JS file '#{src}' should have cache-busting hash"
      end
      
      # Check for proper loading attributes
      defer = script[:defer]
      async = script[:async]
      assert defer || async,
        "Script '#{src}' should have defer or async attribute for performance"
    end
  end
  
  def test_breadcrumb_partial_when_present
    # Visit a page that might have breadcrumbs
    visit "/blog"
    
    # Breadcrumbs might be implemented via JSON-LD or HTML
    breadcrumb_json = all('script[type="application/ld+json"]')
                       .find { |script| script.text.include?("BreadcrumbList") }
    
    if breadcrumb_json
      json_content = JSON.parse(breadcrumb_json.text)
      assert_equal "BreadcrumbList", json_content["@type"],
        "Breadcrumb JSON-LD should have correct type"
      assert json_content["itemListElement"].present?,
        "Breadcrumb should have list elements"
    end
  end
  
  def test_image_optimization_shortcodes
    # Visit a content-rich page
    visit "/about-us"
    
    # Check for optimized images
    images = all("img")
    
    images.each do |img|
      src = img[:src]
      loading = img[:loading]
      
      # Images should have proper loading attributes
      if !src&.include?("data:") # Skip data URLs/placeholders
        assert loading == "lazy" || img == images.first,
          "Images should have lazy loading except for above-fold content"
      end
      
      # Alt text for accessibility
      alt = img[:alt]
      assert alt.present?,
        "Image '#{src}' should have alt text for accessibility"
    end
  end
  
  def test_contact_form_partial_if_present
    # Visit contact page if it exists
    begin
      visit "/contact-us"
      
      # Check for form structure if contact form is present
      if has_selector?("form")
        within "form" do
          # Basic form validation
          assert_selector "input, textarea, select", minimum: 1,
            message: "Contact form should have input fields"
          
          # Check for required accessibility attributes
          required_fields = all("input[required], textarea[required], select[required]")
          required_fields.each do |field|
            id = field[:id]
            name = field[:name]
            
            assert id.present? || name.present?,
              "Required form field should have id or name attribute"
          end
          
          # Check for submit button
          assert_selector "button[type='submit'], input[type='submit']",
            message: "Form should have submit button"
        end
      end
    rescue Capybara::ElementNotFound
      # Contact page doesn't exist or form not present - that's okay
    end
  end
  
  def test_social_sharing_partial
    # Visit a blog post or content page
    visit "/test-testimonial" # Use test page
    
    # Check for social sharing functionality
    if has_selector?(".social-share")
      within ".social-share" do
        # Should have share buttons
        share_links = all("a")
        assert share_links.count >= 1,
          "Should have at least one social sharing link"
        
        share_links.each do |link|
          href = link[:href]
          target = link[:target]
          rel = link[:rel]
          
          # External social links should open in new tab
          assert target == "_blank",
            "Social share link should open in new tab"
          assert rel&.include?("noopener"),
            "Social share link should have noopener for security"
          
          # Should have proper ARIA labels
          aria_label = link[:"aria-label"]
          title = link[:title]
          assert aria_label.present? || title.present?,
            "Social share link should have accessibility label"
        end
      end
    end
  end
end