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

    # Move mouse to (0,0) to prevent menu hover state causing flakiness
    page.driver.browser.action.move_to_location(0, 0).perform

    # Wait for animations to complete
    sleep 0.5

    assert_screenshot "homepage", tolerance: 0.03
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

    assert_stable_screenshot "blog/index/_pagination", skip_area: [".blog-post"], tolerance: 0.03
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

  def test_homepage_sections
    visit "/"

    scroll_to :bottom # preload all images
    assert_text "JetThoughts. All Rights Reserved", exact: false

    verify_section_for("homepage", "services")
    verify_section_for("homepage", "technologies")
    verify_section_for("homepage", "clients")
    verify_section_for("homepage", "cta-contact_us")
    verify_section_for("homepage", "footer")
  end

  def test_clients_sections
    visit "/clients/"

    scroll_to :bottom # preload all images
    assert_text "JetThoughts. All Rights Reserved", exact: false

    verify_section_for("clients", "real-clients", css: '[data-node="ywdijlprtzo2"]')
    verify_section_for("clients", "clients", css: '[data-node="z9jw2gxm5ev0"]')
    verify_section_for("clients", "technologies")
    verify_section_for("clients", "testimonials-header", css: '[data-node="1a4igunq3xvj"]')
    verify_section_for("clients", "testimonials")
    verify_section_for("clients", "cta-contact_us", css: '[data-node="f14gkcmxeo5i"]')
    verify_section_for("clients", "footer", css: "footer")
  end

  def test_client_agent_inbox_sections
    visit "/clients/agent-inbox/"

    scroll_to :bottom # preload all images
    assert_text "JetThoughts. All Rights Reserved", exact: false

    verify_section_for("clients/agent-inbox", "overview", css: '[data-node="pljy58ha90t6"]')
    verify_section_for("clients/agent-inbox", "solution", css: '[data-node="xaj4396uy5vp"]')
    verify_section_for("clients/agent-inbox", "testimonial", css: '[data-node="9oke63pn1lct"]')
    verify_section_for("clients/agent-inbox", "more-cases", css: '[data-node="31daogzev674"]')
    verify_section_for("clients/agent-inbox", "cta-contact_us", css: '[data-node="xwpgvtdncjb2"]')
    verify_section_for("clients/agent-inbox", "footer", css: "footer")
  end

  def test_services
    visit "/services/"

    scroll_to :bottom # preload all images
    assert_text "JetThoughts. All Rights Reserved", exact: false

    verify_section_for("services", "overview", css: '[data-node="i8x1zs2grf9h"]')
    verify_section_for("services", "services", css: '[data-node="nhf6l2ycmzoe"]')
    verify_section_for("services", "technologies")
    verify_section_for("services", "use-cases")
    verify_section_for("services", "testimonials-header", css: '[data-node="1a4igunq3xvj"]')
    verify_section_for("services", "cta-contact_us", css: '[data-node="ohd51ixf3842"]')
    verify_section_for("services", "footer", css: "footer")
  end

  def test_services_fractional_cto_sections
    visit "/services/fractional-cto/"

    scroll_to :bottom # preload all images
    assert_text "JetThoughts. All Rights Reserved", exact: false

    verify_section_for("services/fractional-cto", "overview", css: '[data-node="k8vfnuxaydbe"]')
    verify_section_for("services/fractional-cto", "clients-case-studies", css: '[data-node="9vozd6r548gk"]')
    verify_section_for("services/fractional-cto", "testimonials-header", css: '[data-node="1a4igunq3xvj"]')
    verify_section_for("services/fractional-cto", "testimonials")
    verify_section_for("services/fractional-cto", "cta-contact_us", css: '[data-node="x4hl5foues6i"]')
    verify_section_for("services/fractional-cto", "footer", css: "footer")
  end

  def test_use_cases
    visit "/use-cases/"

    scroll_to :bottom # preload all images
    assert_text "JetThoughts. All Rights Reserved", exact: false

    verify_section_for("use-cases", "overview", css: '[data-node="g2six6yjldnm"]')
    verify_section_for("use-cases", "technologies")
    verify_section_for("use-cases", "testimonials-header", css: '[data-node="1a4igunq3xvj"]')
    verify_section_for("use-cases", "cta-contact_us", css: '[data-node="7l8hya5ixfdo"]')
    verify_section_for("use-cases", "footer", css: "footer")
  end

  def test_use_cases_mvp_sections
    visit "/use-cases/startup-mvp-prototyping-development/"

    scroll_to :bottom # preload all images
    assert_text "JetThoughts. All Rights Reserved", exact: false

    verify_section_for("use-cases/startup-mvp-prototyping-development", "overview", css: '[data-node="ybgzh4il31w2"]')
    verify_section_for("use-cases/startup-mvp-prototyping-development", "solution", css: '[data-node="y9o1fktxjhwd"]')
    verify_section_for("use-cases/startup-mvp-prototyping-development", "clients-case-studies", css: '[data-node="ipax0h7k16zl"]')
    verify_section_for("use-cases/startup-mvp-prototyping-development", "testimonials-header", css: '[data-node="1a4igunq3xvj"]')
    verify_section_for("use-cases/startup-mvp-prototyping-development", "cta-contact_us", css: '[data-node="9s3uy48afhtg"]')
    verify_section_for("use-cases/startup-mvp-prototyping-development", "footer", css: "footer")
  end

  def test_careers
    visit "/careers/"

    assert_stable_screenshot "careers"

    scroll_to :bottom # preload all images
    assert_text "JetThoughts. All Rights Reserved", exact: false

    verify_section_for("careers", "overview", css: '[data-node="w02opu1zjdef"]')
    verify_section_for("careers", "offers", css: '[data-node="dkc4gbvj193z"]')
    verify_section_for("careers", "footer", css: "footer")
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

  def test_services_app_web_development_hero_layout
    visit "/services/app-web-development/"

    preload_all_images

    # Move mouse to prevent menu hover state
    page.driver.browser.action.move_to_location(0, 0).perform

    # Verify hero section exists and is properly styled
    hero_section = find(".fl-row-content-wrap", match: :first, visible: true)
    refute_nil hero_section, "Hero section must exist"

    # Visual regression test with tight tolerance to catch layout issues
    # This will FAIL until c-hero-sections.css is properly integrated
    assert_screenshot "services/app_web_development_hero", tolerance: 0.03
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

  def test_privacy_policy
    visit "/privacy-policy/"

    assert_stable_screenshot "privacy-policy"
  end

  def test_about_page_sections
    visit "/about-us/"

    preload_all_images

    verify_section_for("about_page", "missions", css: '[data-node="uiyz63qn8r0f"]')
    verify_section_for("about_page", "values", css: '[data-node="os8vrc1dwlji"]')
    verify_section_for("about_page", "achievements", css: '[data-node="nb2thxdw075q"]')
    verify_section_for("about_page", "testimonials-header", css: '[data-node="1a4igunq3xvj"]')
    verify_section_for("about_page", "cta-contact_us", css: '[data-node="3h8mj6w59d2c"]')
    verify_section_for("about_page", "footer", css: "footer")
  end

  private

  def verify_section_for(page_name, section_id, css: nil)
    scroll_to find(css || "##{section_id}")
    # Ruby hash-based config handles tolerance automatically
    assert_screenshot "#{page_name}/_#{section_id}"
  end

  def within_top_bar
    within ".navigation" do
      yield
    end
  end
end
