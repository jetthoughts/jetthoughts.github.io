# frozen_string_literal: true

require "application_system_test_case"

class DesktopSiteTest < ApplicationSystemTestCase
  def setup
    Capybara.current_driver = :desktop_chrome
    screenshot_section "desktop"
    super
  end

  def test_homepage
    visit "/"
    assert_text "Build faster. Scale smarter."
    assert_matches_screenshot "homepage", wait: 5, stability_time_limit: 3
  end

  def test_homepage_sections
    visit "/"
    scroll_to :bottom # to preload all images
    assert_text "JetThoughts’s expert team of developers", exact: false

    sections = %w[clients companies testimonials services technologies why-us cta use-cases cta-contact_us footer]

    sections.each do |section_id|
      scroll_to find("##{section_id}")
      assert_matches_screenshot "homepage/_#{section_id}", tolerance: 0.1
    end
  end

  def test_blog_index
    visit "/"
    within_top_bar do
      click_on "Blog"
    end

    assert_matches_screenshot "blog/index", skip_area: [".blog-post"]
  end

  def test_blog_index_pagination
    visit "/blog/"

    scroll_to find("#pagination")

    assert_matches_screenshot "blog/index/_pagination", skip_area: [".blog-post"], wait: 3, stability_time_limit: 0.25
  end

  def test_visit_blog_post
    visit "/"
    within_top_bar { click_on "Blog" }

    within(".fl-heading") { assert_text "Blog" }
    find(".blog a.link", match: :first).click
  end

  def test_blog_post
    visit "/blog/red-flags-watch-for-in-big-pr-when-stop-split-or-rework-development-productivity/"

    assert_matches_screenshot "blog/post"
  end

  def test_about_us
    visit "/"
    within_top_bar do
      click_on "About Us"
    end

    assert_matches_screenshot "about_us", wait: 5, stability_time_limit: 3
  end

  def test_clients
    visit "/"

    within_top_bar do
      click_on "Clients"
    end

    sleep 1

    assert_matches_screenshot "clients", wait: 5, stability_time_limit: 0.25
  end

  def test_clients_sections
    visit "/"
    scroll_to :bottom # to preload all images

    sections = %w[clients technologies cta-contact_us footer]

    sections.each do |section_id|
      scroll_to find("##{section_id}")
      assert_matches_screenshot "clients/_#{section_id}", wait: 5, stability_time_limit: 2, tolerance: 0.1
    end
  end

  def test_careers
    visit "/"
    within_top_bar do
      click_on "Careers"
    end

    assert_matches_screenshot "careers", wait: 5, stability_time_limit: 3
  end

  def test_services_menu
    visit "/"

    within_top_bar do
      find("a", text: "Services").hover
    end

    sleep 1

    assert_matches_screenshot "nav/services", wait: nil, stability_time_limit: nil
  end

  def test_services_fractional_cto
    visit "/"

    within_top_bar do
      find("a", text: "Services").hover
      click_on "Fractional CTO"
    end

    assert_matches_screenshot "services/fractional_cto", wait: nil, stability_time_limit: nil
  end

  def test_services_app_development
    visit "/"

    within_top_bar do
      find("a", text: "Services").hover
      click_on "App/Web Development"
    end

    assert_matches_screenshot "services/app_web_development", wait: 5, stability_time_limit: 3
  end

  def test_use_cases_menu
    visit "/"

    within_top_bar do
      find("a", text: "Use Cases").hover
    end

    sleep 1

    assert_matches_screenshot "nav/use_cases", wait: nil, stability_time_limit: nil
  end

  def test_contact_us
    visit "/"
    click_on "Contact Us", exact: false, match: :first

    assert_text "Let’s get started now"
    assert_matches_screenshot "contact_us", wait: 5, stability_time_limit: 3
  end

  def test_free_consultation
    visit "/"

    click_on "Talk to an Expert", exact: false, match: :first

    assert_text "Free Consultation"
    assert_matches_screenshot "free_consultation", wait: 5, stability_time_limit: 3
  end

  def test_not_found
    visit "/404.html"

    assert_matches_screenshot "404", wait: 5, stability_time_limit: 0.25
  end

  private

  def within_top_bar
    within ".navigation" do
      yield
    end
  end
end
