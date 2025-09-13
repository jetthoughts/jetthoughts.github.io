# frozen_string_literal: true

require "application_system_test_case"

class DataPartialsTest < ApplicationSystemTestCase
  # Test data processing partials functionality and rendering
  
  def test_blog_posts_partial_renders_blog_data
    visit "/blog"
    
    # blog-posts.html partial should filter and return blog posts
    if has_selector?("article, .post, .blog-post")
      blog_posts = all("article, .post, .blog-post")
      
      # Should have multiple blog posts
      assert blog_posts.count >= 1,
        "Blog posts partial should render blog posts on blog page"
      
      blog_posts.first(3).each do |post|
        within post do
          # Each blog post should have essential elements
          assert_selector "h1, h2, h3, .title, .heading", minimum: 1,
            message: "Blog post should have title from blog data"
          
          # Should have publication date
          date_selectors = ["time", ".date", ".published", ".post-date", "[datetime]"]
          has_date = date_selectors.any? { |selector| has_selector?(selector) }
          assert has_date,
            "Blog post should show publication date from metadata"
          
          # Should have link to full post
          assert_selector "a[href*='/blog/']",
            message: "Blog post should have link to full article"
        end
      end
    end
  end
  
  def test_blog_posts_data_structure_and_content
    visit "/blog"
    
    # Test that blog posts partial processes Hugo page data correctly
    if has_selector?("article, .post")
      first_post = find("article, .post")
      
      within first_post do
        # Should have structured content from frontmatter
        title_element = find("h1, h2, h3, .title, .heading")
        title_text = title_element.text.strip
        
        # Title should not be empty and should be meaningful
        assert title_text.length > 5,
          "Blog post title should be substantial and from frontmatter data"
        
        # Should process and display excerpt or summary
        content_areas = [".excerpt", ".summary", ".content", "p"]
        has_content = content_areas.any? { |selector| has_selector?(selector) }
        assert has_content,
          "Blog post should display excerpt or content from partial processing"
        
        # Should have proper URL structure from Hugo page data
        link = find("a[href*='/blog/']")
        href = link[:href]
        assert href.match?(/\/blog\/[\w-]+/),
          "Blog post URL should follow Hugo's URL structure"
      end
    end
  end
  
  def test_clients_partial_processes_client_data_correctly
    # Test on homepage where clients are typically displayed
    visit "/"
    
    client_areas = [".clients", ".client-list", ".testimonials", ".portfolio"]
    
    client_areas.each do |area|
      if has_selector?(area)
        within area do
          client_items = all(".client, .testimonial, .portfolio-item, article")
          
          if client_items.any?
            client_items.first(3).each do |item|
              within item do
                # Clients should have identifiable content
                has_name = has_selector?(".name, .client-name, h3, h4") ||
                          has_text?(/[A-Z][a-z]+ [A-Z][a-z]+/) # Name pattern
                has_logo = has_selector?("img, svg, .logo")
                has_company = has_selector?(".company, .organization") ||
                             has_text?(/Inc\.|Corp\.|LLC|Ltd\./)
                
                content_present = has_name || has_logo || has_company
                assert content_present,
                  "Client partial should render client data with name, logo, or company"
                
                # Should have proper image optimization if logo present
                if has_selector?("img")
                  img = find("img")
                  assert img[:alt].present?,
                    "Client logo should have alt text for accessibility"
                  
                  # Should have proper loading attributes
                  loading_optimized = img[:loading] == "lazy" || img[:decoding] == "async"
                  assert loading_optimized,
                    "Client images should have performance optimization attributes"
                end
              end
            end
          end
        end
      end
    end
  end
  
  def test_clients_data_filtering_and_organization
    visit "/"
    
    # Test that clients partial correctly filters page type "clients"
    if has_selector?(".clients, .client-grid")
      within ".clients, .client-grid" do
        # Should organize clients in a structured way
        client_containers = all(".client, .client-item, .grid > *, .flex > *")
        
        if client_containers.any?
          # Should have consistent structure across clients
          first_client = client_containers.first
          has_structured_layout = first_client.matches_css?(".client") ||
                                 first_client.matches_css?(".grid > *") ||
                                 first_client.matches_css?(".flex > *")
          
          assert has_structured_layout,
            "Clients partial should organize data in structured layout"
          
          # Test data consistency across multiple clients
          if client_containers.count >= 2
            client_containers.first(2).each do |client|
              # Each client should have similar data structure
              has_content_structure = client.has_selector?("img, svg") ||
                                    client.has_selector?(".name, h3, h4") ||
                                    client.text.strip.present?
              
              assert has_content_structure,
                "Each client should have consistent data structure from partial"
            end
          end
        end
      end
    end
  end
  
  def test_services_partial_displays_service_information
    # Test services partial on homepage and services page
    test_pages = ["/", "/services"]
    
    test_pages.each do |page|
      visit page rescue next
      
      service_areas = [".services", ".service-list", ".offerings", ".capabilities"]
      
      service_areas.each do |area|
        if has_selector?(area)
          within area do
            service_items = all(".service, .offering, .capability, article")
            
            if service_items.any?
              service_items.first(4).each do |service|
                within service do
                  # Services should have title and description
                  assert_selector "h1, h2, h3, h4, .title, .heading", minimum: 1,
                    message: "Service should have title from service data"
                  
                  # Should have descriptive content
                  content_areas = [".description", ".content", "p", ".excerpt"]
                  has_description = content_areas.any? { |sel| has_selector?(sel) }
                  assert has_description,
                    "Service should have description content from partial data"
                  
                  # Should have proper internal linking
                  if has_selector?("a[href*='/services/']")
                    service_link = find("a[href*='/services/']")
                    href = service_link[:href]
                    assert href.match?(/\/services\/[\w-]+/),
                      "Service link should follow Hugo URL structure"
                  end
                end
              end
            end
          end
        end
      end
    end
  end
  
  def test_services_data_categorization_and_structure
    visit "/services" rescue visit("/")
    
    # Test that services partial properly processes and categorizes service data
    if has_selector?(".services, .service-grid, .offerings")
      within ".services, .service-grid, .offerings" do
        service_elements = all(".service, .offering, article")
        
        if service_elements.any?
          # Services should be properly categorized from frontmatter
          service_elements.first(3).each do |service|
            within service do
              # Should have service metadata
              title = find("h1, h2, h3, h4, .title").text.strip
              assert title.length > 3,
                "Service title should be substantial from frontmatter"
              
              # Should have service-specific content
              has_tech_content = has_text?(/Ruby|Rails|React|JavaScript|Development|Consulting/)
              has_business_content = has_text?(/CTO|Strategy|Team|Project|Solutions/)
              
              service_relevant = has_tech_content || has_business_content
              assert service_relevant,
                "Service content should be relevant to JetThoughts offerings"
              
              # Should have proper call-to-action if present
              if has_selector?("a.btn, .button, .cta")
                cta = find("a.btn, .button, .cta")
                assert cta[:href].present?,
                  "Service CTA should have proper href from partial processing"
              end
            end
          end
        end
      end
    end
  end
  
  def test_data_partials_performance_and_caching
    visit "/"
    
    # Test that data partials are optimized for performance
    
    # Blog posts should not load excessive data on homepage
    blog_sections = all(".blog, .latest-posts, .recent-posts")
    blog_sections.each do |section|
      within section do
        blog_posts = all("article, .post")
        # Should limit posts for performance (typically 3-6 on homepage)
        assert blog_posts.count <= 10,
          "Homepage should not load excessive blog posts for performance"
      end
    end
    
    # Client logos should be optimized
    client_images = all(".clients img, .client-list img")
    client_images.first(5).each do |img|
      # Should have proper loading optimization
      assert img[:loading] == "lazy" || img[:decoding] == "async",
        "Client images should use performance optimization"
      
      # Should have reasonable dimensions
      width = img[:width]&.to_i
      height = img[:height]&.to_i
      if width && height
        total_pixels = width * height
        assert total_pixels < 100000, # Reasonable limit
          "Client images should have reasonable dimensions for performance"
      end
    end
  end
  
  def test_data_partials_error_handling
    visit "/"
    
    # Test that partials handle missing or empty data gracefully
    # This tests the robustness of the where clauses in the partials
    
    # Should not show empty sections that would indicate partial errors
    problematic_selectors = [
      ".clients:empty", 
      ".services:empty", 
      ".blog-posts:empty"
    ]
    
    problematic_selectors.each do |selector|
      empty_section = find(selector, visible: false) rescue nil
      if empty_section && empty_section.visible?
        flunk "Data partial should not render empty visible sections: #{selector}"
      end
    end
    
    # Should have fallback content or hide sections with no data
    data_sections = [".clients", ".services", ".blog-posts", ".latest-posts"]
    data_sections.each do |section|
      if has_selector?(section)
        within section do
          has_content = has_selector?("article, .item, .post, .service, .client") ||
                       has_text?(/coming soon|check back|no.*available/i)
          
          assert has_content,
            "Data section should have content or appropriate fallback message"
        end
      end
    end
  end
  
  def test_data_partials_accessibility_and_semantics
    visit "/"
    
    # Test that data partials generate accessible HTML structure
    
    # Blog posts should use proper semantic HTML
    if has_selector?(".blog, .posts")
      within ".blog, .posts" do
        # Should use article elements for blog posts
        if has_selector?("article")
          articles = all("article")
          articles.first(2).each do |article|
            within article do
              # Article should have proper heading hierarchy
              headings = all("h1, h2, h3, h4, h5, h6")
              assert headings.any?,
                "Blog post article should have heading element"
              
              # Should have proper time elements for dates
              if has_selector?("time")
                time_elem = find("time")
                assert time_elem[:datetime].present?,
                  "Time element should have datetime attribute"
              end
            end
          end
        end
      end
    end
    
    # Services should use proper semantic structure
    if has_selector?(".services")
      within ".services" do
        # Should use proper heading hierarchy
        headings = all("h1, h2, h3, h4")
        if headings.any?
          first_heading = headings.first
          heading_level = first_heading.tag_name.match(/\d/).to_s.to_i
          assert heading_level >= 2,
            "Service headings should follow proper hierarchy (h2 or lower on pages)"
        end
      end
    end
  end
end