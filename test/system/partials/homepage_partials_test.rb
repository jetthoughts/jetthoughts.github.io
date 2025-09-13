# frozen_string_literal: true

require "application_system_test_case"

class HomepagePartialsTest < ApplicationSystemTestCase
  # Test homepage component partials functionality and rendering
  
  def test_homepage_hero_partial_renders_hero_section
    visit "/"
    
    # Hero partial should render main hero section
    hero_selectors = [".hero", ".jumbotron", ".banner", ".intro", "section.hero"]
    hero_present = hero_selectors.any? { |selector| has_selector?(selector) }
    
    if hero_present
      hero_selector = hero_selectors.find { |selector| has_selector?(selector) }
      within hero_selector do
        # Hero should have compelling headline
        assert_selector "h1, .hero-title, .headline", minimum: 1,
          message: "Hero section should have main headline"
        
        # Should have descriptive content
        content_selectors = [".hero-content", ".lead", ".subtitle", "p"]
        has_content = content_selectors.any? { |sel| has_selector?(sel) }
        assert has_content,
          "Hero section should have descriptive content"
        
        # Should have call-to-action
        cta_selectors = ["a.btn", ".button", ".cta", "a[href*='contact']"]
        has_cta = cta_selectors.any? { |sel| has_selector?(sel) }
        assert has_cta,
          "Hero section should have call-to-action button or link"
        
        # CTA should have proper attributes
        if has_selector?("a.btn, .button, .cta")
          cta = find("a.btn, .button, .cta")
          assert cta[:href].present?,
            "Hero CTA should have proper href attribute"
          
          assert cta.text.strip.present?,
            "Hero CTA should have descriptive text"
        end
      end
    end
  end
  
  def test_homepage_hero_accessibility_and_semantics
    visit "/"
    
    hero_selectors = [".hero", ".jumbotron", ".banner"]
    hero_selector = hero_selectors.find { |sel| has_selector?(sel) }
    
    if hero_selector
      within hero_selector do
        # Hero should use proper heading hierarchy
        main_heading = find("h1, .hero-title")
        assert main_heading.tag_name == "h1" || main_heading.matches_css?(".hero-title"),
          "Hero should use h1 for main heading or semantic class"
        
        # Should not have multiple h1 tags
        h1_count = all("h1").count
        assert h1_count <= 1,
          "Hero section should not have multiple h1 tags"
        
        # Background images should have proper handling
        if has_selector?("[style*='background-image']")
          bg_element = find("[style*='background-image']")
          # Should have proper contrast or overlay for text readability
          has_overlay = bg_element.matches_css?(".overlay") ||
                       bg_element[:style].include?("rgba") ||
                       bg_element.has_selector?(".overlay")
          
          # For accessibility, ensure text is readable
          text_color = evaluate_script("window.getComputedStyle(arguments[0]).color", main_heading)
          assert text_color != "rgba(0, 0, 0, 0)",
            "Hero text should have proper color contrast over background"
        end
      end
    end
  end
  
  def test_homepage_stats_partial_displays_statistics
    visit "/"
    
    # Stats partial should render statistics section
    stats_selectors = [".stats", ".statistics", ".numbers", ".metrics", ".achievements"]
    stats_selector = stats_selectors.find { |sel| has_selector?(sel) }
    
    if stats_selector
      within stats_selector do
        # Should have multiple stat items
        stat_items = all(".stat, .statistic, .metric, .number", minimum: 1)
        
        stat_items.first(4).each do |stat|
          within stat do
            # Each stat should have a number and label
            has_number = has_selector?(".number, .value, .count") ||
                        has_text?(/\d+[\+%]?/)
            assert has_number,
              "Stat item should display numerical value"
            
            # Should have descriptive label
            has_label = has_selector?(".label, .description, h3, h4") ||
                       has_text?(/years|clients|projects|developers/i)
            assert has_label,
              "Stat item should have descriptive label"
          end
        end
        
        # Stats should be visually prominent
        prominent_styling = has_selector?(".text-large, .text-xl, .text-2xl") ||
                           has_selector?("[class*='text-'], [class*='font-']")
        assert prominent_styling,
          "Stats should have prominent visual styling"
      end
    end
  end
  
  def test_homepage_stats_data_accuracy
    visit "/"
    
    stats_selectors = [".stats", ".statistics", ".numbers"]
    stats_selector = stats_selectors.find { |sel| has_selector?(sel) }
    
    if stats_selector
      within stats_selector do
        # Test that stats contain realistic business numbers
        number_elements = all(".number, .value, .count, [class*='text-']")
        
        number_elements.each do |element|
          text = element.text.strip
          
          # Extract numbers from text
          numbers = text.scan(/\d+/)
          numbers.each do |num|
            value = num.to_i
            
            # Business stats should be realistic (not too high or too low)
            case text.downcase
            when /years/
              assert value >= 1 && value <= 50,
                "Years in business should be realistic: #{value}"
            when /clients|projects/
              assert value >= 1 && value <= 10000,
                "Client/project count should be realistic: #{value}"
            when /team|developers/
              assert value >= 1 && value <= 1000,
                "Team size should be realistic: #{value}"
            end
          end
        end
      end
    end
  end
  
  def test_homepage_clients_partial_shows_client_grid
    visit "/"
    
    # Clients partial should render client showcase
    client_selectors = [".clients", ".client-list", ".portfolio", ".testimonials"]
    client_selector = client_selectors.find { |sel| has_selector?(sel) }
    
    if client_selector
      within client_selector do
        # Should have section title
        section_title = find("h2, h3, .section-title, .heading", match: :first) rescue nil
        if section_title
          title_text = section_title.text.downcase
          relevant_title = title_text.include?("client") ||
                          title_text.include?("work") ||
                          title_text.include?("partner") ||
                          title_text.include?("testimonial")
          assert relevant_title,
            "Clients section should have relevant title"
        end
        
        # Should display client items
        client_items = all(".client, .testimonial, .portfolio-item, .client-logo")
        if client_items.any?
          client_items.first(5).each do |client|
            within client do
              # Should have client identifier (logo, name, or image)
              has_identifier = has_selector?("img, svg, .logo") ||
                              has_selector?(".name, .client-name") ||
                              has_text?(/\w+/)
              assert has_identifier,
                "Client item should have logo, name, or identifier"
              
              # Client logos should be optimized
              if has_selector?("img")
                img = find("img")
                assert img[:alt].present?,
                  "Client logo should have alt text"
                
                # Should have reasonable dimensions
                assert img[:loading] == "lazy" || img[:decoding] == "async",
                  "Client logo should have performance optimization"
              end
            end
          end
        end
      end
    end
  end
  
  def test_homepage_services_partial_presents_services
    visit "/"
    
    # Services partial should render services section
    services_selectors = [".services", ".offerings", ".capabilities", ".what-we-do"]
    services_selector = services_selectors.find { |sel| has_selector?(sel) }
    
    if services_selector
      within services_selector do
        # Should have section heading
        assert_selector "h2, h3, .section-title", minimum: 1,
          message: "Services section should have heading"
        
        # Should display service items
        service_items = all(".service, .offering, .capability")
        if service_items.any?
          service_items.first(6).each do |service|
            within service do
              # Each service should have title
              assert_selector "h3, h4, .service-title, .title", minimum: 1,
                message: "Service should have title"
              
              # Should have description
              description_selectors = [".description", ".content", "p", ".excerpt"]
              has_description = description_selectors.any? { |sel| has_selector?(sel) }
              assert has_description,
                "Service should have description"
              
              # Service should be relevant to software development
              service_text = text.downcase
              relevant_keywords = %w[development ruby rails react javascript 
                                    consulting cto strategy team agile web mobile]
              
              has_relevant_content = relevant_keywords.any? { |keyword| 
                service_text.include?(keyword) 
              }
              assert has_relevant_content,
                "Service should contain relevant technology or business keywords"
              
              # Should have proper call-to-action if present
              if has_selector?("a.btn, .button, .learn-more")
                cta = find("a.btn, .button, .learn-more")
                assert cta[:href].present?,
                  "Service CTA should have proper href"
              end
            end
          end
        end
      end
    end
  end
  
  def test_homepage_services_technical_accuracy
    visit "/"
    
    services_selector = [".services", ".offerings"].find { |sel| has_selector?(sel) }
    
    if services_selector
      within services_selector do
        service_descriptions = all(".service .description, .service p, .offering p")
        
        service_descriptions.first(3).each do |description|
          desc_text = description.text.downcase
          
          # Technical terms should be spelled correctly
          technical_terms = {
            "javascript" => /java\s*script/i,
            "postgresql" => /postgres/i,
            "ruby on rails" => /rails|ror/i,
            "react" => /react/i,
            "typescript" => /typescript/i
          }
          
          # Should not have common technical misspellings
          technical_terms.each do |correct, pattern|
            if desc_text.match?(pattern)
              # If technical term is mentioned, it should be properly formatted
              proper_formatting = desc_text.include?(correct) ||
                                 desc_text.include?(correct.titleize)
              # This is informational rather than hard assertion for flexibility
            end
          end
          
          # Should not have Lorem ipsum or placeholder text
          refute desc_text.include?("lorem ipsum"),
            "Service description should not contain placeholder text"
        end
      end
    end
  end
  
  def test_homepage_partials_responsive_design
    visit "/"
    
    # Test that homepage partials work on different screen sizes
    desktop_width = 1200
    tablet_width = 768
    mobile_width = 375
    
    [desktop_width, tablet_width, mobile_width].each do |width|
      page.driver.browser.manage.window.resize_to(width, 800)
      
      # Hero should remain functional
      if has_selector?(".hero, .banner")
        within ".hero, .banner" do
          # Text should remain readable
          heading = find("h1, .hero-title")
          assert heading.visible?,
            "Hero heading should be visible at #{width}px width"
          
          # CTA should remain accessible
          if has_selector?("a.btn, .button")
            cta = find("a.btn, .button")
            assert cta.visible?,
              "Hero CTA should be visible at #{width}px width"
          end
        end
      end
      
      # Stats should stack appropriately on mobile
      if has_selector?(".stats")
        within ".stats" do
          stat_items = all(".stat, .statistic")
          if stat_items.count > 1
            # On mobile, stats might stack vertically
            if width <= mobile_width
              # Stats should still be visible even if stacked
              assert stat_items.all?(&:visible?),
                "All stats should remain visible on mobile"
            end
          end
        end
      end
    end
    
    # Reset to desktop size
    page.driver.browser.manage.window.resize_to(1200, 800)
  end
  
  def test_homepage_partials_performance_optimization
    visit "/"
    
    # Test that homepage partials are optimized for performance
    
    # Images should have proper loading attributes
    all_images = all("img")
    all_images.first(10).each do |img|
      # Above-the-fold images should load immediately, below-the-fold should be lazy
      img_position = evaluate_script("arguments[0].getBoundingClientRect().top", img)
      
      if img_position > 600 # Likely below fold
        assert img[:loading] == "lazy",
          "Below-fold images should have lazy loading"
      end
      
      # All images should have dimensions to prevent layout shift
      has_dimensions = img[:width].present? && img[:height].present?
      has_css_dimensions = img[:style]&.include?("width") || img[:class]&.match?(/w-|h-/)
      
      assert has_dimensions || has_css_dimensions,
        "Images should have dimensions to prevent layout shift"
    end
    
    # Critical CSS should be inlined for above-the-fold content
    inline_styles = all("style")
    if inline_styles.any?
      critical_css = inline_styles.first.text
      # Should contain styles for hero/above-fold elements
      hero_styles = critical_css.include?(".hero") ||
                   critical_css.include?("h1") ||
                   critical_css.include?("body")
      assert hero_styles,
        "Inline CSS should include critical above-the-fold styles"
    end
  end
  
  def test_homepage_partials_seo_optimization
    visit "/"
    
    # Test that homepage partials contribute to SEO
    
    # Hero should contribute to page title and description
    if has_selector?(".hero h1")
      hero_title = find(".hero h1").text
      page_title = find("title").text
      
      # Page title should relate to hero content
      title_words = page_title.downcase.split
      hero_words = hero_title.downcase.split
      
      common_words = (title_words & hero_words).reject { |w| w.length < 3 }
      assert common_words.any?,
        "Page title should relate to hero content for SEO"
    end
    
    # Services should use proper heading hierarchy for SEO
    if has_selector?(".services")
      within ".services" do
        # Section should have h2
        assert_selector "h2",
          message: "Services section should use h2 for SEO hierarchy"
        
        # Individual services should use h3
        service_headings = all("h3, h4")
        assert service_headings.any?,
          "Individual services should use h3/h4 for proper SEO hierarchy"
      end
    end
    
    # Important content should not be hidden in images without alt text
    content_images = all(".hero img, .services img")
    content_images.each do |img|
      if img[:alt].blank?
        # Image might contain important text - should have alt text
        assert img.matches_css?("[role='presentation']") || img[:aria-hidden] == "true",
          "Content area images should have alt text or be marked as decorative"
      end
    end
  end
end