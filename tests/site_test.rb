# frozen_string_literal: true

require "test_helper"

class SiteTest < ApplicationSystemTestCase
  def test_homepage
    visit "/"
    scroll_to :bottom # to preload all images

    assert_matches_screenshot "homepage", skip_area: [".jt-counter-number-ready"], wait: 5, stability_time_limit: 3
  end

  def test_homepage_sections
    visit "/"
    scroll_to :bottom # to preload all images

    sections = %w[clients companies testimonials services technologies why-us cta use-cases cta-contact_us footer]

    sections.each do |section_id|
      scroll_to find("##{section_id}")
      sleep 1.5
      assert_matches_screenshot "homepage/_#{section_id}", wait: nil, stability_time_limit: nil
    end
  end

  def test_blog_index
    visit "/"
    within_top_bar do
      click_on "Blog"
    end
    assert_success_response

    assert_matches_screenshot "blog/index"
  end

  def test_visit_blog_post
    visit "/"
    within_top_bar { click_on "Blog" }

    find(".blog-post .post-content .link", match: :first).click

    assert_text "Read next"
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

    assert_success_response

    assert_matches_screenshot "about_us", wait: 5, stability_time_limit: 3
  end

  def test_clients
    visit "/"
    within_top_bar do
      click_on "Clients"
    end

    assert_success_response

    assert_matches_screenshot "clients", wait: 5, stability_time_limit: 3
  end


  def test_clients_sections
    visit "/"
    scroll_to :bottom # to preload all images

    sections = %w[clients technologies cta-contact_us footer]

    sections.each do |section_id|
      scroll_to find("##{section_id}")
      sleep 1
      assert_matches_screenshot "clients/_#{section_id}", wait: nil, stability_time_limit: nil
    end
  end


  def test_careers
    visit "/"
    within_top_bar do
      click_on "Careers"
    end

    assert_success_response

    assert_matches_screenshot "careers", wait: 5, stability_time_limit: 3
  end

  def test_services_fractional_cto
    visit "/"

    within_top_bar do
      find("a", text: "Services").hover
      click_on "Fractional CTO"
    end

    assert_success_response
    assert_matches_screenshot "services/fractional_cto", wait: nil
  end

  def test_services_app_development
    visit "/"

    within_top_bar do
      find("a", text: "Services").hover
      click_on "App/Web Development"
    end

    assert_success_response
    assert_matches_screenshot "services/app_web_development", wait: 5, stability_time_limit: 3
  end

  def test_contact_us
    visit "/"
    click_on "Contact Us", exact: false, match: :first

    assert_text "Let’s get started now"
    assert_matches_screenshot "contact_us", wait: 5, stability_time_limit: 3
  end

  private

  def assert_success_response
    assert_equal 200, page.status_code
  end

  def within_top_bar
    within "nav" do
      yield
    end
  end
end