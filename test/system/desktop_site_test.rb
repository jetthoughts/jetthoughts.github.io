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

  def test_homepage_sections
    visit "/"
    scroll_to :bottom # to preload all images
    assert_text "JetThoughts’s expert team of developers", exact: false

    sections = %w[clients companies testimonials services technologies why-us cta use-cases cta-contact_us footer]

    sections.each do |section_id|
      scroll_to find("##{section_id}")
      # Use appropriate screenshot method based on section type
      case section_id
      when "testimonials", "why-us"
        assert_stable_problematic_screenshot "homepage/_#{section_id}"
      when "cta", "cta-contact_us", "use-cases"
        # Use CTA method for sections with dynamic content/animations
        assert_cta_screenshot "homepage/_#{section_id}"
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
    find(".blog a.link", match: :first).click
  end

  def test_blog_post
    visit "/blog/red-flags-watch-for-in-big-pr-when-stop-split-or-rework-development-productivity/"

    assert_stable_screenshot "blog/post"
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

    sleep 1

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
        assert_stable_problematic_screenshot "clients/_#{section_id}"
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
      find("a", text: "Services").hover
    end

    sleep 1

    assert_quick_screenshot "nav/services"
  end

  def test_services_fractional_cto
    visit "/"

    within_top_bar do
      find("a", text: "Services").hover
      click_on "Fractional CTO"
    end

    assert_quick_screenshot "services/fractional_cto"
  end

  def test_services_app_development
    visit "/"

    within_top_bar do
      find("a", text: "Services").hover
      click_on "App/Web Development"
    end

    assert_stable_problematic_screenshot "services/app_web_development"
  end

  def test_use_cases_menu
    visit "/"

    within_top_bar do
      find("a", text: "Use Cases").hover
    end

    sleep 1

    assert_quick_screenshot "nav/use_cases"
  end

  def test_contact_us
    visit "/"
    click_on "Contact Us", exact: false, match: :first

    assert_text "Let’s get started now"
    assert_stable_problematic_screenshot "contact_us"
  end

  def test_free_consultation
    visit "/"

    click_on "Talk to an Expert", exact: false, match: :first

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
