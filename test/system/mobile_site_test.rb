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

    assert_stable_problematic_screenshot "homepage", tolerance: 0.018
  end

  def test_blog_index
    visit "/blog/"

    # Use problematic method due to higher variance in blog content
    assert_stable_problematic_screenshot "blog/index", skip_area: [".blog-post"]
  end

  def test_blog_index_pagination
    visit "/blog/"

    scroll_to find("#pagination")

    assert_stable_problematic_screenshot "blog/index/_pagination", skip_area: [".blog-post"]
  end

  def test_visit_blog_post
    visit "/blog/"

    find(".blog a.link", match: :first).click

    assert_selector ".single-content header .heading"
  end

  def test_blog_post
    visit "/blog/red-flags-watch-for-in-big-pr-when-stop-split-or-rework-development-productivity/"

    assert_stable_screenshot "blog/post"
  end

  def test_about_us
    visit "/about-us/"

    assert_stable_problematic_screenshot "about_us", skip_area: [".fl-photo-img"]
  end

  def test_clients
    visit "/clients/"

    preload_all_images

    assert_stable_screenshot "clients"
  end

  def test_careers
    visit "/careers/"

    assert_stable_problematic_screenshot "careers"
  end

  def test_top_bar_hamburger_menu
    visit "/"

    open_mobile_menu

    assert_stable_problematic_screenshot "nav/hamburger_menu", stability_time_limit: 0.5
  end

  def test_top_bar_hamburger_menu_services
    visit "/"

    open_mobile_menu

    find(".js-sub-menu-opener", match: :first).click
    wait_menu_to_render

    assert_stable_problematic_screenshot "nav/hamburger_menu/services"
  end

  def test_contact_us
    visit "/contact-us/"

    assert_text "Let’s get started now"
    assert_stable_problematic_screenshot "contact_us", skip_stack_frames: 1
  end

  def test_free_consultation
    visit "/"
    click_on "Talk to an Expert", exact: false, match: :first

    assert_text "Free Consultation"
    assert_stable_problematic_screenshot "free_consultation"
  end

  def test_not_found
    visit "/404.html"

    assert_stable_problematic_screenshot "404"
  end

  private

  def open_mobile_menu
    find(".js-mobile-menu-opener").click
    wait_menu_to_render
  end

  def wait_menu_to_render
    sleep 1
  end

  def preload_all_images
    scroll_to :bottom
    scroll_to :top
    sleep 2
  end
end
