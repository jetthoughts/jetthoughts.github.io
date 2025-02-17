# frozen_string_literal: true

require "test_helper"

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

    assert_matches_screenshot "homepage"
  end

  def test_blog_index
    visit "/blog/"

    assert_matches_screenshot "blog/index", skip_area: [".blog-post"]
  end

  def test_blog_index_pagination
    visit "/blog/"

    scroll_to find("#pagination")

    assert_matches_screenshot "blog/index/_pagination", skip_area: [".blog-post"], wait: 3, stability_time_limit: 0.25
  end

  def test_visit_blog_post
    visit "/blog/"

    find(".blog a.link", match: :first).click

    assert_selector ".single-content header .heading"
  end

  def test_blog_post
    visit "/blog/red-flags-watch-for-in-big-pr-when-stop-split-or-rework-development-productivity/"

    assert_matches_screenshot "blog/post"
  end

  def test_about_us
    visit "/about-us/"

    assert_matches_screenshot "about_us", wait: 5, stability_time_limit: 3
  end

  def test_clients
    visit "/clients/"

    preload_all_images

    assert_matches_screenshot "clients", wait: nil, stability_time_limit: nil
  end

  def test_careers
    visit "/careers/"

    assert_matches_screenshot "careers", wait: 5, stability_time_limit: 3
  end

  def test_top_bar_hamburger_menu
    visit "/"

    open_mobile_menu

    assert_matches_screenshot "nav/hamburger_menu", wait: 3, stability_time_limit: 0.025
  end

  def test_top_bar_hamburger_menu_services
    visit "/"

    open_mobile_menu

    find(".js-sub-menu-opener", match: :first).click
    wait_menu_to_render

    assert_matches_screenshot "nav/hamburger_menu/services", wait: 2, stability_time_limit: 1
  end

  def test_contact_us
    visit "/contact-us/"

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

    assert_matches_screenshot "404", wait: 5, stability_time_limit: 3
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
