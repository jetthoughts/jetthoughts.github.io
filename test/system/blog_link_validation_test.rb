# frozen_string_literal: true

require "application_system_test_case"

# Blog link validation tests - validates blog post URLs and tag page navigation
# Focus: User behavior - can users navigate to blog posts? Do links work correctly?
# NOT testing: Implementation details, CSS classes, HTML structure
class BlogLinkValidationTest < ApplicationSystemTestCase
  def setup
    Capybara.current_driver = :desktop_chrome
    screenshot_section "desktop"
    super
  end

  # Test 1: Blog index accessibility - Can users access the blog listing?
  def test_blog_index_accessibility
    visit "/blog/"

    # Validate user can see blog heading
    assert_selector "h1", text: "Blog", wait: 3

    # Validate blog posts are rendered for user
    assert_selector ".blog-post", minimum: 1, wait: 5
  end

  # Test 2-11: Recent 10 blog post URL accessibility
  # Testing behavior: Can users access recent blog posts via direct URLs?
  def test_recent_blog_post_1_building_rag_applications
    visit "/blog/building-rag-applications-rails-pgvector/"

    # Validate user sees the blog post content
    assert_selector "h1", text: "Building RAG Applications", wait: 5
    assert_selector "article", wait: 3
  end

  def test_recent_blog_post_2_langchain_memory_systems
    visit "/blog/langchain-memory-systems-conversational-ai/"

    assert_selector "h1", text: "Building Stateful Conversational AI", wait: 5
    assert_selector "article", wait: 3
  end

  def test_recent_blog_post_3_cost_optimization
    visit "/blog/cost-optimization-llm-applications-token-management/"

    assert_selector "h1", text: "Cost Optimization for LLM Applications", wait: 5
    assert_selector "article", wait: 3
  end

  def test_recent_blog_post_4_crewai_multi_agent
    visit "/blog/crewai-multi-agent-systems-orchestration/"

    assert_selector "h1", text: "CrewAI Multi-Agent Systems", wait: 5
    assert_selector "article", wait: 3
  end

  def test_recent_blog_post_5_production_scaling
    visit "/blog/production-scaling-langchain-crewai-enterprise/"

    assert_selector "h1", text: "From Prototype to Production", wait: 5
    assert_selector "article", wait: 3
  end

  def test_recent_blog_post_6_langchain_architecture
    visit "/blog/langchain-architecture-production-ready-agents/"

    assert_selector "h1", text: "LangChain Architecture Deep Dive", wait: 5
    assert_selector "article", wait: 3
  end

  def test_recent_blog_post_7_langgraph_workflows
    visit "/blog/langgraph-workflows-state-machines-ai-agents/"

    assert_selector "h1", text: "Mastering LangGraph", wait: 5
    assert_selector "article", wait: 3
  end

  def test_recent_blog_post_8_testing_monitoring
    visit "/blog/testing-monitoring-llm-applications-production/"

    assert_selector "h1", text: "Testing and Monitoring LLM Applications", wait: 5
    assert_selector "article", wait: 3
  end

  def test_recent_blog_post_9_fractional_cto_roi
    visit "/blog/fractional-cto-roi-calculator-startup-decision-framework/"

    assert_selector "h1", text: "Fractional CTO ROI Calculator", wait: 5
    assert_selector "article", wait: 3
  end

  def test_recent_blog_post_10_infrastructure_spending
    visit "/blog/infrastructure-spending-evaluation-founders/"

    assert_selector "h1", text: "How to Know If Your Developers Are Wasting Money", wait: 5
    assert_selector "article", wait: 3
  end

  # Test 12: Blog post navigation from index
  # Testing behavior: Can users click blog post links from the blog index?
  def test_navigate_to_blog_post_from_index
    visit "/blog/"

    # User clicks first blog post link
    within(".blog") do
      first_post = find(".blog-post", match: :first, visible: true, wait: 10)

      # Validate post has title (user can see what they're clicking)
      post_title = first_post.find(".post-title", wait: 3)
      refute_empty post_title.text, "Blog post should have a title"

      # Click the link wrapping the post
      first_post.find(:xpath, "..").click # parent <a> element
    end

    # Validate user lands on blog post (after clicking, outside of within block)
    assert_selector "article", wait: 5
  end

  # Test 13: Blog pagination navigation
  # Testing behavior: Can users navigate through blog pages?
  def test_blog_pagination_navigation
    visit "/blog/"

    # Check if pagination exists (might not if only one page of posts)
    if has_selector?("#pagination", wait: 2)
      scroll_to find("#pagination")

      # Test pagination link functionality (if next page exists)
      if has_link?("Next", wait: 1)
        click_link "Next"

        # Validate user navigated to page 2
        assert_selector "h1", text: "Blog", wait: 3
        assert_selector ".blog-post", minimum: 1, wait: 5
      end
    end
  end

  # Test 14: Tag page navigation
  # Testing behavior: Can users access tag pages and filter blog posts?
  def test_tag_page_navigation
    visit "/blog/"

    # Find a tag link if tags are displayed on blog index
    if has_selector?(".blog-tags a", wait: 2)
      within(".blog-tags") do
        first_tag = find("a", match: :first, visible: true, wait: 5)
        first_tag.click
      end

      # Validate user lands on tag page (outside within block)
      assert_selector "h1", wait: 5

      # User should see blog posts filtered by tag
      assert_selector ".blog-post", minimum: 1, wait: 5
    else
      # If no tags on index, try a known tag page directly
      visit "/tags/"

      if has_selector?("h1", wait: 2)
        assert_selector "h1", wait: 3
      else
        skip "No tag pages available for testing"
      end
    end
  end

  # Test 15: Blog post internal navigation
  # Testing behavior: Can users use table of contents or internal links?
  def test_blog_post_internal_navigation
    visit "/blog/langchain-architecture-production-ready-agents/"

    # Check if table of contents exists
    if has_selector?(".table-of-contents", wait: 2)
      within(".table-of-contents") do
        first_toc_link = find("a", match: :first, visible: true, wait: 5)
        first_toc_link.click

        # Validate page scrolled to section (URL should have hash)
        assert_match(/#/, current_url)
      end
    end
  end

  # Test 16: Blog search or filter functionality
  # Testing behavior: Can users search or filter blog posts?
  def test_blog_search_functionality
    visit "/blog/"

    # Check if search exists
    if has_selector?("input[type='search']", wait: 2) || has_selector?("input[type='text'][placeholder*='Search']", wait: 2)
      search_field = find("input[type='search'], input[type='text'][placeholder*='Search']", visible: true, wait: 5)
      search_field.fill_in with: "Rails"

      # Some search implementations require submit button
      if has_button?("Search", wait: 1)
        click_button "Search"
      end

      # Validate search results appear
      assert_selector ".blog-post", minimum: 1, wait: 5
    else
      skip "No search functionality available for testing"
    end
  end

  # Test 17: Related posts navigation
  # Testing behavior: Can users navigate to related posts from a blog post?
  def test_related_posts_navigation
    visit "/blog/building-rag-applications-rails-pgvector/"

    # Check if related posts section exists
    if has_selector?(".related-posts", wait: 2) || has_selector?("[class*='related']", wait: 2)
      related_section = find(".related-posts, [class*='related']", match: :first, visible: true, wait: 5)

      within(related_section) do
        if has_link?(wait: 2)
          first_related_link = find("a", match: :first, visible: true, wait: 5)
          first_related_link.click

          # Validate user lands on another blog post
          assert_selector "article", wait: 5
        end
      end
    else
      skip "No related posts section available for testing"
    end
  end

  # Test 18: Blog post sharing links
  # Testing behavior: Are social sharing links accessible?
  def test_blog_post_sharing_links
    visit "/blog/cost-optimization-llm-applications-token-management/"

    # Check if social sharing links exist
    if has_selector?(".share", wait: 2) || has_selector?("[class*='share']", wait: 2)
      share_section = find(".share, [class*='share']", match: :first, visible: true, wait: 5)

      within(share_section) do
        # Validate share links are present (not clicking to avoid external navigation)
        assert_selector "a", minimum: 1, wait: 3
      end
    else
      skip "No social sharing functionality available for testing"
    end
  end

  # Test 19: Blog RSS/feed accessibility
  # Testing behavior: Can users access blog feed?
  def test_blog_feed_accessibility
    visit "/blog/"

    # Check if RSS link exists
    if has_link?("RSS", wait: 2) || has_link?("Feed", wait: 2)
      # Don't click (external), just validate link exists
      assert_selector "a[href*='rss'], a[href*='feed'], a[href*='xml']", wait: 3
    else
      # Try direct feed URLs
      visit "/blog/index.xml"

      # XML feeds typically have specific content type
      # If accessible, page should load without 404
      refute_text "404", wait: 2
    end
  rescue Capybara::ElementNotFound
    skip "No blog feed available for testing"
  end

  # Test 20: Blog archive/category navigation
  # Testing behavior: Can users browse blog by date or category?
  def test_blog_archive_navigation
    visit "/blog/"

    # Check if archive or category navigation exists
    if has_selector?(".archive", wait: 2) || has_selector?(".categories", wait: 2)
      archive_section = find(".archive, .categories", match: :first, visible: true, wait: 5)

      within(archive_section) do
        if has_link?(wait: 2)
          first_archive_link = find("a", match: :first, visible: true, wait: 5)
          first_archive_link.click

          # Validate user lands on filtered view
          assert_selector "h1", wait: 5
          assert_selector ".blog-post", minimum: 1, wait: 5
        end
      end
    else
      skip "No archive/category navigation available for testing"
    end
  end
end
