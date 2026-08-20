# frozen_string_literal: true

require "application_system_test_case"

class MobileSiteTest < ApplicationSystemTestCase
  def setup
    Capybara.current_driver = :mobile_chrome
    screenshot_section "mobile"
    super
  end

  def test_homepage
    visit "/"
    assert_text "Your dev shop stopped delivering. We rescue and stabilize."

    preload_all_images

    assert_stable_screenshot "homepage", tolerance: 0.03
  end

  def test_blog_index
    visit "/blog/"

    # Use stable method due to consistency improvements
    assert_stable_screenshot "blog/index", skip_area: [".blog-post", ".post-feature"]
  end

  def test_blog_index_pagination
    visit "/blog/"

    scroll_to find("#pagination")

    assert_stable_screenshot "blog/index/_pagination", skip_area: [".blog-post", ".post-feature"], tolerance: 0.03
  end

  def test_blog_tag_page
    visit "/blog/tags/rails/"

    # Same masks as desktop: rows churn with tagging, the lead carries the
    # live post count.
    assert_stable_screenshot "blog/tag", skip_area: [".blog-post", ".blog-lead"]
  end

  def test_visit_blog_post
    visit "/blog/"

    # Wait for blog posts to load and find the first clickable link within the blog container
    within(".blog") do
      find("a.link", match: :first, visible: true, wait: 10).click
    end

    # Wait for navigation to complete and page to load
    assert_selector ".post-title,.fl-heading,.heading,[role=title]", wait: 10
  end

  def test_blog_post
    visit "/blog/red-flags-watch-for-in-big-pr-when-stop-split-or-rework-development-productivity/"

    assert_stable_screenshot "blog/post", tolerance: 0.03, skip_area: %w[picture img]
  end

  def test_privacy_policy
    visit "/privacy-policy/"

    assert_stable_screenshot "privacy-policy"
  end

  def test_course_landing
    visit "/course/tech-for-non-technical-founders-2026/"

    within "h1" do
      assert_text "From Idea to First Paying Customer", normalize_ws: true
    end

    assert_stable_screenshot "course/landing", tolerance: 0.03, skip_area: %w[picture img]
  end

  def test_careers_ruby
    visit "/careers/junior-ruby-on-rails-developer/"

    assert_stable_screenshot "careers/junior-ruby-on-rails-developer", tolerance: 0.03, skip_area: %w[picture img]
  end

  def test_client_single_full
    visit "/clients/agent-inbox/"

    assert_selector "h1", text: "Agent Inbox"

    assert_stable_screenshot "clients/single-full", tolerance: 0.03, skip_area: %w[picture img]
  end

  def test_course_chapter
    visit "/course/tech-for-non-technical-founders-2026/form-your-founding-hypothesis-90-minute-sprint/"

    # blockquote: the lesson-meta callout's bold+link line wraps bimodally
    # across runs (font-swap race), flipping every pixel below it.
    assert_stable_screenshot "course/chapter", tolerance: 0.03, skip_area: %w[picture img blockquote]
  end

  def test_about_us
    visit "/about-us/"

    assert_stable_screenshot "about_us", skip_area: [".fl-photo-img"]
  end

  def test_services
    visit "/services/"

    assert_stable_screenshot "services", tolerance: 0.03, skip_area: %w[picture img]
  end

  def test_service_single
    visit "/services/fractional-cto/"

    assert_stable_screenshot "services/fractional_cto", tolerance: 0.03, skip_area: %w[picture img]
  end

  def test_use_cases
    visit "/use-cases/"

    assert_stable_screenshot "use_cases", tolerance: 0.03, skip_area: %w[picture img]
  end

  def test_use_case_single
    visit "/use-cases/startup-mvp-prototyping-development/"

    assert_stable_screenshot "use_cases/startup-mvp-prototyping-development", tolerance: 0.03, skip_area: %w[picture img]
  end

  def test_clients
    visit "/clients/"

    preload_all_images

    assert_stable_screenshot "clients"
  end

  def test_careers
    visit "/careers/"

    assert_stable_screenshot "careers"
  end

  def test_top_bar_hamburger_menu
    visit "/"

    open_mobile_menu

    assert_stable_screenshot "nav/hamburger_menu", stability_time_limit: 0.5
  end

  def test_top_bar_hamburger_menu_services
    visit "/"

    open_mobile_menu

    # Add better scoping for sub-menu opener
    within(".navigation") do
      find(".js-sub-menu-opener", match: :first, visible: true, wait: 5).click
    end
    wait_menu_to_render

    assert_stable_screenshot "nav/hamburger_menu/services"
  end

  def test_contact_us
    visit "/contact-us/"

    assert_text "Let’s get started now"
    assert_stable_screenshot "contact_us"
  end

  def test_vibe_code_rescue
    visit "/services/vibe-code-rescue/"

    assert_text "Your MVP looks finished but keeps breaking"
    assert_text "$7,500"
    assert_link "Book your free Rescue Context Call"
    assert_stable_screenshot "vibe_code_rescue"
  end

  def test_friday_report
    visit "/friday-report/"

    # The ICP reads this on a phone: the artifact and the honesty label must
    # both survive the narrow column, not just the desktop layout.
    assert_text "The Friday report you get every week"
    assert_text "What slipped, and why"
    assert_text "This is a composite example, not a real client's report"
    assert_link "Get a free code audit", minimum: 2

    # No screenshot baseline yet - see the desktop test for why.
  end

  def test_free_consultation
    visit "/"
    # Add more specific scoping for Talk to an Expert button
    find("a", text: "Talk to an Expert", match: :first, wait: 5).click

    assert_text "Get a free code audit"
    assert_text "one-page written assessment"
    assert_button "Request my code audit"
    assert_stable_screenshot "free_consultation"
  end

  def test_not_found
    visit "/404.html"

    assert_stable_screenshot "404"
  end

  def test_about_page_section_core_values
    visit "/about-us/"
    preload_all_images

    scroll_to(find(".about-values-header-col"))
    assert_stable_screenshot "about_page/values", tolerance: 0.03
  end

  def test_about_page_section_achievements
    visit "/about-us/"
    preload_all_images

    scroll_to(find(".about-achievements-eyebrow"))
    assert_stable_screenshot "about_page/achievements", tolerance: 0.03
  end

  private

  def open_mobile_menu
    # Mobile menu opener is outside the header element
    find(".js-mobile-menu-opener", visible: true, wait: 5).click
    wait_menu_to_render
  end

  def wait_menu_to_render
    # Wait for navigation menu to fully render
    has_selector?(".navigation .js-sub-menu-opener", visible: true, wait: 3)
  end
end
