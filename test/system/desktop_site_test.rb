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
    assert_screenshot "homepage", tolerance: 0.10
  end

  def test_top_image_have_highest_priority
    visit "/"
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

  def test_homepage_section_hero
    verify_homepage_section("hero")
  end

  def test_homepage_section_stats
    verify_homepage_section("stats")
  end

  def test_homepage_section_why_us
    verify_homepage_section("why-us")
  end

  def test_homepage_section_use_cases
    visit "/"
    scroll_to :bottom # preload all images
    assert_text "JetThoughts. All Rights Reserved", exact: false
    # Use cases is loaded via partial, need to find the container
    scroll_to find("#use-cases") rescue scroll_to find(".use-cases")
    assert_screenshot "homepage/_use_cases", tolerance: 0.09
  end

  def test_homepage_section_testimonials
    visit "/"
    scroll_to :bottom # preload all images
    assert_text "JetThoughts. All Rights Reserved", exact: false
    # Testimonials is loaded via partial, need to find the container
    scroll_to find("#testimonials") rescue scroll_to find(".testimonials")
    assert_screenshot "homepage/_testimonials"
  end

  def test_services_outsourced_developer_staffing
    visit "/services/outsourced-developer-staffing/"
    assert_stable_screenshot "services/outsourced_developer_staffing"
  end

  def test_services_fractional_product_management
    visit "/services/fractional-product-management/"
    assert_stable_screenshot "services/fractional_product_management"
  end

  def test_services_software_qa_cat
    visit "/services/software-qa-cat/"
    assert_stable_screenshot "services/software_qa_cat"
  end

  def test_services_fractional_cto_cost
    visit "/services/fractional-cto-cost/"
    assert_stable_screenshot "services/fractional_cto_cost"
  end

  def test_services_emergency_cto_leadership
    visit "/services/emergency-cto-leadership/"
    assert_stable_screenshot "services/emergency_cto_leadership"
  end

  def test_services_startup_cto_consulting
    visit "/services/startup-cto-consulting/"
    assert_stable_screenshot "services/startup_cto_consulting"
  end

  def test_services_technical_leadership_consulting
    visit "/services/technical-leadership-consulting/"
    assert_stable_screenshot "services/technical_leadership_consulting"
  end

  def test_services_engineering_management_consulting
    visit "/services/engineering-management-consulting/"
    assert_stable_screenshot "services/engineering_management_consulting"
  end

  def test_services_talent_recruiting_training
    visit "/services/talent-recruiting-training/"
    assert_stable_screenshot "services/talent_recruiting_training"
  end

  def test_services_fractional_cto_services
    visit "/services/fractional-cto-services/"
    assert_stable_screenshot "services/fractional_cto_services"
  end

  def test_services_index
    visit "/services/"
    assert_stable_screenshot "services/index"
  end

  def test_use_cases_emergency_cto_leadership
    visit "/use-cases/emergency-cto-leadership/"
    assert_stable_screenshot "use_cases/emergency_cto_leadership"
  end

  def test_use_cases_accelerate_development_maximize_capacity
    visit "/use-cases/accelerate-development-maximize-capacity/"
    assert_stable_screenshot "use_cases/accelerate_development_maximize_capacity"
  end

  def test_use_cases_automate_product_qa_testing
    visit "/use-cases/automate-product-qa-testing/"
    assert_stable_screenshot "use_cases/automate_product_qa_testing"
  end

  def test_use_cases_salvage_existing_project
    visit "/use-cases/salvage-existing-project/"
    assert_stable_screenshot "use_cases/salvage_existing_project"
  end

  def test_use_cases_empower_existing_engineering_team
    visit "/use-cases/empower-existing-engineering-team/"
    assert_stable_screenshot "use_cases/empower_existing_engineering_team"
  end

  def test_use_cases_startup_mvp_prototyping_development
    visit "/use-cases/startup-mvp-prototyping-development/"
    assert_stable_screenshot "use_cases/startup_mvp_prototyping_development"
  end

  def test_privacy_policy
    visit "/privacy-policy/"
    assert_stable_screenshot "privacy_policy"
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

    assert_stable_screenshot "blog/post", tolerance: 0.03
  end

  def test_about_us
    visit "/"
    visit_via_menu("About Us")
    assert_screenshot "about_us"
  end

  def test_clients
    visit "/"

    within_top_bar do
      click_on "Clients"
    end

    assert_selector("h1", text: "Real people. Real experiences", wait: 3)
    assert_stable_screenshot "clients"
  end

  def test_misc_sections
    visit "/"
    verify_section("clients")
    verify_section("technologies")
    verify_section("cta-contact_us")
    verify_section("footer")
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
    assert_screenshot "nav/services", tolerance: 0.01
  end

  def test_services_fractional_cto
    visit "/"
    visit_via_menu("Services", "Fractional CTO")
    assert_screenshot "services/fractional_cto"
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

  def test_clients_agent_inbox
    visit "/clients/agent-inbox/"
    assert_stable_screenshot "clients/agent_inbox"
  end

  def test_clients_lime_leads
    visit "/clients/see-how-jetthoughts-helped-limeleads-transform-a-legacy-codebase-stabilize-the-product-for-long-term-performance/"
    assert_stable_screenshot "clients/lime_leads"
  end

  def test_clients_mobile_coach
    visit "/clients/mobile-coach/"
    assert_stable_screenshot "clients/mobile_coach"
  end

  def test_clients_open_apply
    visit "/clients/open-apply/"
    assert_stable_screenshot "clients/open_apply"
  end

  def test_clients_crosslake
    visit "/clients/see-how-jetthoughts-helped-crosslake-transform-a-legacy-software-project-gain-control-over-a-complex-codebase/"
    assert_stable_screenshot "clients/crosslake"
  end

  def test_clients_ocs
    visit "/clients/see-how-jetthoughts-helped-orchestratecs-go-from-an-idea-to-software-in-just-60-days/"
    assert_stable_screenshot "clients/ocs"
  end

  private

  def verify_homepage_section(section_id)
    visit "/"
    verify_section(section_id)
  end

  def verify_section(section_id)
    preload_all_images
    scroll_to find("##{section_id}")
    assert_screenshot "homepage/_#{section_id}"
  end

  def within_top_bar
    within ".navigation" do
      yield
    end
  end
end
