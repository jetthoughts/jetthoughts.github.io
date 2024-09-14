# frozen_string_literal: true

require "test_helper"

class MobileSiteTest < ApplicationSystemTestCase
  def setup
    page.driver.resize(360, 800)
    screenshot_section "mobile"
  end

  def test_homepage
    visit "/"
    sleep 2

    assert_matches_screenshot "homepage", skip_area: [".counter-value"]
  end

  def test_blog_index
    visit "/blog/"

    assert_matches_screenshot "blog/index"
  end

  def test_visit_blog_post
    visit "/blog/"

    find(".blog-post .post-content .link", match: :first).click

    assert_text "Read next"
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
    sleep 5

    assert_matches_screenshot "clients", wait: nil, stability_time_limit: nil
  end

  def test_careers
    visit "/careers/"

    assert_matches_screenshot "careers", wait: 5, stability_time_limit: 3
  end

  def test_top_bar_hamburger_menu
    visit "/"

    find(".pp-advanced-menu-mobile-toggle.hamburger").click
    sleep 1

    assert_matches_screenshot "nav/hamburger_menu", wait: nil, stability_time_limit: nil
  end

  def test_top_bar_hamburger_menu_services
    visit "/"

    page.driver.resize(360, 800)

    find(".pp-advanced-menu-mobile-toggle.hamburger").click
    find(".pp-menu-toggle", match: :first).click
    sleep 1

    assert_matches_screenshot "nav/hamburger_menu/services", wait: nil, stability_time_limit: nil
  end

  def test_contact_us
    visit "/contact-us/"

    assert_text "Let’s get started now"
    assert_matches_screenshot "contact_us", wait: 5, stability_time_limit: 3
  end
end
