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
    assert_text "Build faster. Scale smarter."

    preload_all_images

    assert_stable_screenshot "homepage", tolerance: 0.03
  end

  def test_blog_index
    visit "/blog/"

    # Use stable method due to consistency improvements
    assert_stable_screenshot "blog/index", skip_area: [".blog-post"]
  end

  def test_blog_index_pagination
    visit "/blog/"

    scroll_to find("#pagination")

    assert_stable_screenshot "blog/index/_pagination", skip_area: [".blog-post"]
  end

  def test_visit_blog_post
    visit "/blog/"

    # Wait for blog posts to load and find the first clickable link within the blog container
    within(".blog") do
      find("a.link", match: :first, visible: true, wait: 10).click
    end

    # Wait for navigation to complete and page to load
    assert_selector ".single-content header .fl-heading", wait: 10
  end

  def test_blog_post
    visit "/blog/red-flags-watch-for-in-big-pr-when-stop-split-or-rework-development-productivity/"

    assert_stable_screenshot "blog/post", tolerance: 0.03, skip_area: %w[picture img]
  end

  def test_about_us
    visit "/about-us/"

    assert_stable_screenshot "about_us", skip_area: [".fl-photo-img"]
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
    assert_stable_screenshot "about_page/values", tolerance: 0.03
  end

  def test_about_page_section_achievements
    visit "/about-us/"
    preload_all_images

    scroll_to(find(".fl-node-nb2thxdw075q"))
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
