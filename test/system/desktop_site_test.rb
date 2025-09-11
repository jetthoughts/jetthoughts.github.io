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
    assert_stable_problematic_screenshot "homepage"
  end

  def test_top_image_have_highest_priority
    visit "/"
    within ".fl-photo-content.fl-photo-img-jpeg" do
      assert_css "img[fetchpriority=high]"
    end
  end

  # Generate individual test methods for each homepage section
  %w[clients technologies cta-contact_us footer].each do |section_id|
    define_method("test_homepage_section_#{section_id.tr("-", "_")}") do
      visit "/"
      scroll_to :bottom # to preload all images
      assert_text "JetThoughts’s expert team of developers", exact: false

      scroll_to find("##{section_id}")

      # Use appropriate screenshot method based on section type
      case section_id
      when "testimonials", "why-us"
        assert_stable_problematic_screenshot "homepage/_#{section_id}"
      when "cta", "cta-contact_us", "use-cases"
        # Use CTA method for sections with dynamic content/animations
        assert_cta_screenshot "homepage/_#{section_id}"
      when "technologies"
        assert_stable_problematic_screenshot "homepage/_#{section_id}"
      else
        assert_stable_screenshot "homepage/_#{section_id}", tolerance: 0.02
      end
    end
  end

  def test_blog_index
    visit "/"
    within_top_bar do
      click_on "Blog"
    end

    assert_stable_screenshot "blog/index", skip_area: [".blog-post"]
  end

  def test_blog_index_pagination
    visit "/blog/"

    scroll_to find("#pagination")

    assert_stable_problematic_screenshot "blog/index/_pagination", skip_area: [".blog-post"]
  end

  def test_visit_blog_post
    visit "/"
    within_top_bar { click_on "Blog" }

    within(".fl-heading") { assert_text "Blog" }
    # Replace assert_selector + first().click with single find().click
    find(".blog a.link", match: :first, visible: true, wait: 5).click
  end

  def test_blog_post
    visit "/blog/red-flags-watch-for-in-big-pr-when-stop-split-or-rework-development-productivity/"

    assert_stable_screenshot "blog/post", tolerance: 0.15
  end

  def test_about_us
    visit "/"
    within_top_bar do
      click_on "About Us"
    end

    assert_stable_problematic_screenshot "about_us"
  end

  def test_clients
    visit "/"

    within_top_bar do
      click_on "Clients"
    end

    assert_selector("h1", text: "Real people. Real experiences", wait: 3)
    assert_stable_screenshot "clients"
  end

  def test_clients_sections
    visit "/"
    scroll_to :bottom # to preload all images

    sections = %w[clients technologies cta-contact_us footer]

    sections.each do |section_id|
      scroll_to find("##{section_id}")
      # Use appropriate screenshot method based on section type
      case section_id
      when "clients"
        assert_stable_screenshot "clients/_#{section_id}", tolerance: 0.15
      when "cta-contact_us"
        assert_cta_screenshot "clients/_#{section_id}"
      else
        assert_stable_screenshot "clients/_#{section_id}", tolerance: 0.02
      end
    end
  end

  def test_careers
    visit "/"
    within_top_bar do
      click_on "Careers"
    end

    assert_stable_problematic_screenshot "careers"
  end

  def test_services_menu
    visit "/"

    within_top_bar do
      find("a", text: "Services", visible: true, wait: 5).hover
    end

    assert_selector(".sub-menu", visible: true, wait: 2)
    assert_quick_screenshot "nav/services"
  end

  def test_services_fractional_cto
    visit "/"

    within_top_bar do
      find("a", text: "Services", visible: true, wait: 5).hover
      click_on "Fractional CTO"
    end

    assert_quick_screenshot "services/fractional_cto", tolerance: 0.20
  end

  def test_services_app_development
    visit "/"

    within_top_bar do
      find("a", text: "Services", visible: true, wait: 5).hover
      click_on "App/Web Development"
    end

    assert_stable_problematic_screenshot "services/app_web_development"
  end

  def test_use_cases_menu
    visit "/"

    within_top_bar do
      find("a", text: "Use Cases", visible: true, wait: 5).hover
    end

    assert_selector(".sub-menu", visible: true, wait: 2)
    assert_quick_screenshot "nav/use_cases"
  end

  def test_contact_us
    visit "/"
    # Add more specific scoping for Contact Us button
    within(".navigation") do
      click_on "Contact Us", exact: false, wait: 5
    end

    # Wait for page to fully load and text to be visible
    assert_text "get started", wait: 10, exact: false
    assert_stable_problematic_screenshot "contact_us"
  end

  def test_free_consultation
    visit "/"

    # Add more specific scoping for Talk to an Expert button
    find("a", text: "Talk to an Expert", match: :first, wait: 5).click

    assert_text "Free Consultation"
    assert_stable_problematic_screenshot "free_consultation"
  end

  def test_not_found
    visit "/404.html"

    assert_stable_screenshot "404"
  end

  private

  def within_top_bar
    within ".navigation" do
      yield
    end
  end
end
