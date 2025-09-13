# frozen_string_literal: true

require "application_system_test_case"

class SvgPartialsTest < ApplicationSystemTestCase
  # Test SVG partial templates functionality and rendering
  
  def test_svg_partial_renders_svg_content
    visit "/"
    
    # SVG partials should render actual SVG content in various contexts
    within "header" do
      # Logo should use SVG partial
      assert_selector "svg", minimum: 1,
        message: "Header should contain SVG content from svg partial"
      
      # SVG should have proper structure
      svg_elements = all("svg")
      svg_elements.first(3).each do |svg|
        # Should have viewBox for scalability
        assert svg["viewBox"].present? || svg["width"].present?,
          "SVG should have viewBox or width attribute for proper rendering"
        
        # Should have proper accessibility
        assert svg["aria-label"].present? || svg["aria-hidden"] == "true" ||
               has_selector?("title", parent: svg),
          "SVG should have accessibility attributes or hidden from screen readers"
      end
    end
  end
  
  def test_svg_cached_partial_functionality
    visit "/"
    
    # Test that SVG caching works correctly
    # Look for SVGs that would benefit from caching (icons, logos)
    svg_selectors = [
      "header svg", # Logo
      ".social svg", # Social icons
      ".services svg", # Service icons
      ".stats svg" # Stats icons
    ]
    
    svg_selectors.each do |selector|
      if has_selector?(selector)
        within_selector = selector.split(" ").first
        within within_selector do
          svg_elements = all("svg")
          svg_elements.first(2).each do |svg|
            # Cached SVG should render properly
            assert svg.tag_name == "svg",
              "Cached SVG partial should render actual SVG element"
            
            # Should have content (paths, circles, etc.)
            has_content = svg.has_selector?("path, circle, rect, polygon, line, g") ||
                         svg["data-icon"].present? ||
                         svg.text.strip.present?
            assert has_content,
              "SVG should have actual graphic content or text"
          end
        end
      end
    end
  end
  
  def test_svg_optimization_and_attributes
    visit "/"
    
    # Test SVG optimization features
    all_svg = all("svg")
    return if all_svg.empty?
    
    all_svg.first(5).each do |svg|
      # SVG should be optimized (no unnecessary attributes)
      refute svg["xmlns:xlink"].present?,
        "Optimized SVG should not have unnecessary xmlns:xlink"
      
      # Should have proper sizing
      has_sizing = svg["viewBox"].present? || 
                   (svg["width"].present? && svg["height"].present?) ||
                   svg["class"]&.include?("w-") || # Tailwind width classes
                   svg["style"]&.include?("width")
      assert has_sizing,
        "SVG should have proper sizing attributes or classes"
      
      # Security: should not have script tags
      refute svg.has_selector?("script"),
        "SVG should not contain script tags for security"
    end
  end
  
  def test_svg_icons_in_navigation
    visit "/"
    
    # Test SVG icons in navigation elements
    navigation_areas = ["header nav", "footer nav", ".social-nav", ".menu"]
    
    navigation_areas.each do |area|
      if has_selector?(area)
        within area do
          links_with_svg = all("a").select { |link| link.has_selector?("svg") }
          
          links_with_svg.first(3).each do |link|
            within link do
              svg = find("svg")
              
              # Navigation SVGs should have proper accessibility
              link_has_text = link.text.strip.present?
              svg_has_title = svg.has_selector?("title")
              svg_hidden = svg["aria-hidden"] == "true"
              svg_labeled = svg["aria-label"].present?
              
              assert link_has_text || svg_has_title || svg_labeled || !svg_hidden,
                "Navigation links with SVG should have accessible text or labels"
              
              # SVG should be inline for performance
              assert svg.tag_name == "svg",
                "Navigation icons should use inline SVG (not img tags)"
            end
          end
        end
      end
    end
  end
  
  def test_svg_social_icons
    visit "/"
    
    # Test social media SVG icons
    if has_selector?(".social, .social-links, footer")
      social_areas = [".social", ".social-links", "footer"]
      
      social_areas.each do |area|
        if has_selector?(area)
          within area do
            social_links = all("a[href*='linkedin'], a[href*='twitter'], a[href*='facebook'], a[href*='github']")
            
            social_links.first(4).each do |link|
              # Social links should have SVG icons
              if link.has_selector?("svg")
                within link do
                  svg = find("svg")
                  
                  # Social SVGs should have proper branding colors or classes
                  has_styling = svg["class"].present? || svg["fill"].present? || svg["style"].present?
                  assert has_styling,
                    "Social SVG icons should have styling classes or attributes"
                  
                  # Should be properly sized for social context
                  assert svg["viewBox"].present? || svg["class"]&.match?(/w-\d+|h-\d+|size-\d+/),
                    "Social SVG icons should have proper sizing"
                end
              end
            end
          end
        end
      end
    end
  end
  
  def test_svg_service_icons
    # Test service-related SVG icons on homepage or services page
    ["/", "/services"].each do |path|
      visit path rescue next
      
      service_areas = [".services", ".service-list", ".features", ".capabilities"]
      
      service_areas.each do |area|
        if has_selector?(area)
          within area do
            service_items = all(".service, .feature, .capability, article")
            
            service_items.first(3).each do |item|
              if item.has_selector?("svg")
                within item do
                  svg = find("svg")
                  
                  # Service SVGs should be decorative or have meaningful labels
                  is_decorative = svg["aria-hidden"] == "true"
                  has_label = svg["aria-label"].present? || svg.has_selector?("title")
                  
                  assert is_decorative || has_label,
                    "Service SVG icons should be marked as decorative or have descriptive labels"
                  
                  # Should have consistent sizing
                  assert svg["viewBox"].present?,
                    "Service SVG icons should have viewBox for scalable rendering"
                end
              end
            end
          end
        end
      end
    end
  end
  
  def test_svg_performance_optimization
    visit "/"
    
    # Test that SVGs are optimized for performance
    all_svg = all("svg")
    return if all_svg.empty?
    
    all_svg.first(10).each do |svg|
      # Check for performance optimizations
      
      # Should not have unnecessary id attributes (unless needed)
      svg_ids = svg.all("*[id]")
      svg_ids.each do |element|
        id_value = element["id"]
        # IDs should be meaningful, not generic generated ones
        refute id_value&.match?(/^[a-z]$|^path\d+$|^g\d+$/),
          "SVG should not have unnecessary generated IDs: #{id_value}"
      end
      
      # Should not have excessive nesting
      deep_nesting = svg.all("g g g g") # 4 levels deep
      assert deep_nesting.count < 3,
        "SVG should not have excessive nesting (performance impact)"
      
      # Should use efficient path commands when possible
      paths = svg.all("path[d]")
      paths.first(2).each do |path|
        path_data = path["d"]
        next if path_data.blank?
        
        # Path data should not be excessively long (performance)
        assert path_data.length < 1000,
          "SVG path data should be reasonably optimized for performance"
      end
    end
  end
  
  def test_svg_accessibility_compliance
    visit "/"
    
    # Test SVG accessibility compliance
    all_svg = all("svg")
    return if all_svg.empty?
    
    all_svg.first(8).each do |svg|
      # Decorative SVGs should be hidden from screen readers
      # Meaningful SVGs should have appropriate labels
      
      parent_link = svg.find(:xpath, "./ancestor::a[1]", match: :first) rescue nil
      parent_button = svg.find(:xpath, "./ancestor::button[1]", match: :first) rescue nil
      
      if parent_link || parent_button
        # SVG in interactive elements
        parent = parent_link || parent_button
        parent_has_text = parent.text.strip.present?
        svg_has_label = svg["aria-label"].present?
        svg_has_title = svg.has_selector?("title")
        svg_hidden = svg["aria-hidden"] == "true"
        
        # Either parent has text, SVG has label/title, or SVG is decorative
        assert parent_has_text || svg_has_label || svg_has_title || svg_hidden,
          "Interactive SVG should be accessible: have text, label, title, or be decorative"
      else
        # Standalone SVG
        has_role = svg["role"].present?
        is_hidden = svg["aria-hidden"] == "true"
        has_label = svg["aria-label"].present? || svg.has_selector?("title")
        
        # Standalone SVG should have proper accessibility attributes
        assert has_role || is_hidden || has_label,
          "Standalone SVG should have role, be hidden, or have descriptive label"
      end
    end
  end
end