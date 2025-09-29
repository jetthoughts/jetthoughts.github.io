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

    preload_all_images

    assert_text "Build faster. Scale smarter."

    begin
      assert_screenshot "homepage", tolerance: 0.10
    rescue
      # FIXME: This is a workaround for a flaky test issue where the screenshot
      assert_screenshot "homepage", tolerance: 0.10
    end
  end

  def test_top_image_have_highest_priority
    visit "/"

    preload_all_images

    within ".fl-photo-content.fl-photo-img-jpeg" do
      assert_css "img[fetchpriority=high]"
    end
  end

  # Explicit test methods for each homepage section (Ruby readability over metaprogramming)
  def test_homepage_section_clients
    verify_homepage_section("clients")
  end

  def test_homepage_section_technologies
    verify_homepage_section("technologies")
  end

  def test_homepage_section_cta_contact_us
    verify_homepage_section("cta-contact_us")
  end

  def test_homepage_section_footer
    verify_homepage_section("footer")
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

    assert_stable_screenshot "blog/index/_pagination", skip_area: [".blog-post"]
  end

  def test_visit_blog_post
    visit "/"
    within_top_bar { click_on "Blog" }

    within(".fl-heading") { assert_text "Blog" }

    # Wait for blog posts to load and find the first clickable link
    within(".blog") do
      find("a.link", match: :first, visible: true, wait: 10).click
    end
  end

  def test_blog_post
    visit "/blog/red-flags-watch-for-in-big-pr-when-stop-split-or-rework-development-productivity/"

    assert_stable_screenshot "blog/post", tolerance: 0.03, stability_time_limit: 5
  end

  def test_about_us
    visit "/"
    visit_via_menu("About Us")
    assert_screenshot "about_us", skip_area: ["article img"], tolerance: 0.005
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
    scroll_to :bottom # preload all images

    verify_clients_section("clients")
    verify_clients_section("technologies")
    verify_clients_section("cta-contact_us")
    verify_clients_section("footer")
  end

  def test_careers
    visit "/"
    within_top_bar do
      click_on "Careers"
    end

    assert_stable_screenshot "careers"
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
    visit_via_menu("Services", "Fractional CTO")
    assert_screenshot "services/fractional_cto", tolerance: 0.20
  end

  def test_services_app_development
    visit "/"

    within_top_bar do
      find("a", text: "Services", visible: true, wait: 5).hover
      click_on "App/Web Development"
    end

    assert_stable_screenshot "services/app_web_development"
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
    assert_stable_screenshot "contact_us"
  end

  def test_free_consultation
    visit "/"

    # Add more specific scoping for Talk to an Expert button
    find("a", text: "Talk to an Expert", match: :first, wait: 5).click

    assert_text "Free Consultation"
    assert_stable_screenshot "free_consultation"
  end

  def test_not_found
    visit "/404.html"

    assert_stable_screenshot "404"
  end

  def test_about_page_section_core_values
    visit "/about-us/"
    preload_all_images

    scroll_to(find(".fl-node-os8vrc1dwlji"))
    assert_stable_screenshot "about_page/values", tolerance: 0.1
  end

  def test_about_page_section_achievements
    visit "/about-us/"
    preload_all_images

    scroll_to(find(".fl-node-nb2thxdw075q"))
    assert_stable_screenshot "about_page/achievements", tolerance: 0.1
  end

  private

  def verify_homepage_section(section_id)
    visit "/"
    scroll_to :bottom # preload all images
    assert_text "JetThoughts. All Rights Reserved", exact: false
    scroll_to find("##{section_id}")
    # Ruby hash-based config automatically handles tolerance per section
    assert_screenshot "homepage/_#{section_id}"
  end

  def verify_clients_section(section_id)
    scroll_to find("##{section_id}")
    # Ruby hash-based config handles tolerance automatically
    assert_screenshot "clients/_#{section_id}"
  end

  def within_top_bar
    within ".navigation" do
      yield
    end
  end
end
