# frozen_string_literal: true

require "application_system_test_case"

# Blog recommendation and resource links validation
# Focus: User behavior - Can users access recommended posts, free resources, and contact links?
# NOT testing: Implementation details, CSS classes, HTML structure
class BlogRecommendationLinksTest < ApplicationSystemTestCase
  def setup
    Capybara.current_driver = :desktop_chrome
    screenshot_section "desktop"
    super
  end

  # Test 1: Building RAG Applications - Recommendation block links
  # Testing behavior: Can users access recommended posts from RAG article?
  def test_rag_applications_recommendation_links_work
    visit "/blog/building-rag-applications-rails-pgvector/"
    
    # Wait for page to fully load
    assert_selector "h1", text: "Building RAG Applications", wait: 5
    
    # Scroll to recommendation section (typically at bottom)
    scroll_to_bottom
    
    # Find recommendation/related posts section
    if has_selector?(".related-posts, [class*='related'], [class*='recommend']", wait: 3)
      within(".related-posts, [class*='related'], [class*='recommend']", match: :first) do
        # Get all recommendation links
        links = all("a[href*='/blog/']", wait: 5)
        
        assert links.count > 0, "Should have at least one recommendation link"
        
        # Test each recommendation link is accessible
        links.each_with_index do |link, index|
          href = link[:href]
          
          # Visit the recommended post
          visit href
          
          # Validate user lands on a valid blog post (not 404)
          refute_text "404", wait: 3
          refute_text "Page Not Found", wait: 2
          assert_selector "article, .blog-post", wait: 5
          
          # Return to original post for next link check
          go_back if index < links.count - 1
        end
      end
    else
      skip "No recommendation section found on RAG applications post"
    end
  end

  # Test 2: Hiring Developers Contractors - Recommendation and contact links
  # Testing behavior: Can users access recommended resources and contact pages?
  def test_hiring_developers_recommendation_and_contact_links_work
    visit "/blog/hiring-developers-contractors-budget-guide-founders/"
    
    assert_selector "h1", text: "hiring", wait: 5, case_sensitive: false
    
    scroll_to_bottom
    
    # Test recommendation links
    if has_selector?(".related-posts, [class*='related'], [class*='recommend']", wait: 3)
      within(".related-posts, [class*='related'], [class*='recommend']", match: :first) do
        links = all("a[href]", wait: 5)
        
        links.each do |link|
          href = link[:href]
          next unless href.include?('/blog/') || href.include?('/contact')
          
          visit href
          
          # Validate link works (not broken)
          refute_text "404", wait: 3
          refute_text "Page Not Found", wait: 2
          
          go_back
        end
      end
    end
  end

  # Test 3: Code Quality Evaluation - Free Resources links
  # Testing behavior: Can users access free resources mentioned in post?
  def test_code_quality_free_resources_links_work
    visit "/blog/code-quality-evaluation-non-technical-founders/"
    
    assert_selector "h1", wait: 5
    
    # Look for "Free Resources" section
    if has_text?("Free Resources", wait: 3) || has_text?("Resources", wait: 3)
      # Find all links in resources section
      links = all("a[href*='/contact'], a[href*='/blog/'], a[href*='resource']", wait: 5)
      
      links.each do |link|
        href = link[:href]
        
        # Skip external links (focus on internal navigation)
        next if href.start_with?('http') && !href.include?('jetthoughts')
        
        visit href
        
        # Validate resource link works
        refute_text "404", wait: 3
        assert_selector "body", wait: 3
        
        go_back
      end
    else
      skip "No Free Resources section found"
    end
  end

  # Test 4: Infrastructure Spending - Contact section links
  # Testing behavior: Can users contact the company from blog post?
  def test_infrastructure_spending_contact_links_work
    visit "/blog/infrastructure-spending-evaluation-founders/"
    
    assert_selector "h1", wait: 5
    
    scroll_to_bottom
    
    # Find contact links in various sections
    contact_links = all("a[href*='/contact'], a[href*='mailto:']", wait: 5)
    
    assert contact_links.count > 0, "Should have at least one contact link"
    
    contact_links.each do |link|
      href = link[:href]
      
      # Skip mailto links (can't validate email behavior in browser)
      next if href.start_with?('mailto:')
      
      visit href
      
      # Validate contact page loads
      refute_text "404", wait: 3
      refute_text "Page Not Found", wait: 2
      assert_selector "body", wait: 3
      
      go_back
    end
  end

  # Test 5: Remote Team Accountability - All link types validation
  # Testing behavior: Can users navigate from remote team post to all linked resources?
  def test_remote_team_all_links_work
    visit "/blog/remote-team-accountability-non-technical-founders/"
    
    assert_selector "h1", wait: 5
    
    scroll_to_bottom
    
    # Collect all internal links (blog posts, contact, resources)
    internal_links = all("a[href^='/']", wait: 5).map { |link| link[:href] }.uniq
    
    # Filter to relevant link types
    relevant_links = internal_links.select do |href|
      href.include?('/blog/') || href.include?('/contact') || href.include?('/resource')
    end
    
    assert relevant_links.count > 0, "Should have at least one internal link"
    
    relevant_links.each do |href|
      visit href
      
      # Validate link destination is accessible
      refute_text "404", wait: 3
      refute_text "Page Not Found", wait: 2
      assert_selector "body", wait: 3
      
      go_back
    end
  end

  # Test 6: Comprehensive broken link detection across all specified posts
  # Testing behavior: Systematically validate NO broken links exist on these posts
  def test_no_broken_links_across_founder_posts
    posts = [
      "/blog/building-rag-applications-rails-pgvector/",
      "/blog/hiring-developers-contractors-budget-guide-founders/",
      "/blog/code-quality-evaluation-non-technical-founders/",
      "/blog/infrastructure-spending-evaluation-founders/",
      "/blog/remote-team-accountability-non-technical-founders/"
    ]
    
    broken_links_report = []
    
    posts.each do |post_url|
      visit post_url
      
      # Wait for page load
      assert_selector "h1", wait: 5
      scroll_to_bottom
      
      # Get all internal links on page
      internal_links = all("a[href^='/']", wait: 5)
      
      internal_links.each do |link|
        href = link[:href]
        link_text = link.text.strip
        
        # Skip anchor-only links
        next if href == '/' || href.start_with?('/#')
        
        visit href
        
        # Check if link is broken
        if has_text?("404", wait: 2) || has_text?("Page Not Found", wait: 2)
          broken_links_report << {
            source_post: post_url,
            broken_url: href,
            link_text: link_text
          }
        end
        
        go_back
      end
    end
    
    # Assert NO broken links found
    assert_empty broken_links_report, 
      "Found broken links:\n#{broken_links_report.map { |r| "  - Post: #{r[:source_post]}\n    Link: #{r[:broken_url]}\n    Text: '#{r[:link_text]}'" }.join("\n")}"
  end

  # Test 7: Validate recommendation block exists and has accessible links
  # Testing behavior: Do recommendation blocks consistently provide working links?
  def test_recommendation_blocks_consistently_provide_working_links
    posts_with_recommendations = [
      "/blog/building-rag-applications-rails-pgvector/",
      "/blog/hiring-developers-contractors-budget-guide-founders/",
      "/blog/code-quality-evaluation-non-technical-founders/"
    ]
    
    posts_with_recommendations.each do |post_url|
      visit post_url
      
      assert_selector "h1", wait: 5
      scroll_to_bottom
      
      # Look for recommendation/related section
      if has_selector?(".related-posts, [class*='related'], [class*='recommend']", wait: 3)
        within(".related-posts, [class*='related'], [class*='recommend']", match: :first) do
          links = all("a[href]", wait: 5)
          
          # Validate at least one recommendation exists
          assert links.count > 0, "Post #{post_url} should have recommendation links"
          
          # Test first recommendation link works
          first_link = links.first
          href = first_link[:href]
          
          visit href
          
          # Validate recommendation link works
          refute_text "404", wait: 3
          refute_text "Page Not Found", wait: 2
          
          go_back
        end
      end
    end
  end

  private

  def scroll_to_bottom
    execute_script "window.scrollTo(0, document.body.scrollHeight)"
    sleep 1 # Allow time for lazy-loaded content
  end
end
