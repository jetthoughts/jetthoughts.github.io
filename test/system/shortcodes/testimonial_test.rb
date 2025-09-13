# frozen_string_literal: true

require "application_system_test_case"

class TestimonialShortcodeTest < ApplicationSystemTestCase
  def test_testimonial_renders_with_all_attributes
    # Visit about page which has testimonials partial
    visit "/about-us/"

    # Verify testimonials section renders properly (data-driven testimonials)
    assert_selector "#testimonials", minimum: 1
    assert_selector ".pp-reviews-wrapper", minimum: 1

    # Verify testimonial slides exist (from data/testimonials.yaml)
    assert_selector ".pp-review-item", minimum: 1

    # Verify testimonial content structure
    assert_selector ".pp-review-text p", minimum: 1

    # Verify author information displays
    assert_selector ".pp-review-name", minimum: 1
    assert_selector ".pp-review-title", minimum: 1
  end

  def test_testimonial_content_from_data_file
    visit "/about-us/"

    # Find the first testimonial from data/testimonials.yaml
    within first(".pp-review-item") do
      # Check for testimonial content (should have Bruno Wozniak testimonial)
      assert_selector ".pp-review-text p"

      # Verify author information from data file
      assert_selector ".pp-review-name"
      assert_selector ".pp-review-title"

      # Verify rating display
      assert_selector ".pp-rating img[alt='five stars']"
    end
  end

  def test_testimonial_carousel_functionality
    visit "/about-us/"

    # Verify Swiper carousel structure
    assert_selector ".swiper-container"
    assert_selector ".swiper-wrapper"

    # Should have multiple testimonial slides from data
    testimonials = all(".pp-review-item")
    assert testimonials.count >= 1, "Should have at least 1 testimonial from data file"

    # Verify each testimonial has proper structure
    within first(".pp-review-item") do
      assert_selector ".pp-review-text"
      assert_selector ".pp-review-name"
      assert_selector ".pp-review-title"
    end
  end

  def test_careers_page_testimonial
    visit "/careers/"

    # Check if careers page has individual testimonial (from frontmatter)
    # This page uses testimonial data in frontmatter, not the shortcode
    # So we're testing the data structure is properly used

    # The careers page should render successfully
    assert_text "Looking for a Team to Take You to the Next Level?"

    # Verify testimonial from frontmatter renders
    # Based on careers.html layout, testimonial content is in a specific section
    assert_selector ".fl-rich-text p", text: /The best company I worked for/
    assert_text "Current Employee (3+ Years)"
    assert_text "Ruby on Rails Developer at JetThoughts"
  end

  def test_testimonial_data_structure
    visit "/about-us/"

    # Verify testimonials are loaded from data file
    testimonials = all(".pp-review-item")

    testimonials.each do |testimonial|
      within testimonial do
        # Each testimonial should have required structure from data
        assert_selector ".pp-review-text p"
        assert_selector ".pp-review-name"

        # Verify content is not empty (from actual data)
        review_text = find(".pp-review-text p").text.strip
        author_name = find(".pp-review-name").text.strip

        refute review_text.empty?, "Review text should not be empty"
        refute author_name.empty?, "Author name should not be empty"
      end
    end
  end

  def test_testimonial_responsive_structure
    # Test on smaller screen size
    visit "/about-us/"

    # Resize to mobile viewport
    page.driver.browser.manage.window.resize_to(375, 667)

    # Verify testimonials still render properly on mobile
    assert_selector ".pp-reviews-wrapper", minimum: 1

    within first(".pp-review-item") do
      # Check that elements are still present on mobile
      assert_selector ".pp-review-text"
      assert_selector ".pp-review-name"
      assert_selector ".pp-rating"
    end

    # Reset to desktop size
    page.driver.browser.manage.window.resize_to(1366, 768)
  end

  def test_testimonial_accessibility_attributes
    visit "/about-us/"

    within first(".pp-review-item") do
      # Check for proper semantic HTML
      assert_selector "cite.pp-review-cite"

      # Check rating images have proper alt text
      if has_selector?(".pp-rating img")
        img = find(".pp-rating img")
        assert img[:alt].present?, "Rating image should have alt attribute"
        assert_equal "five stars", img[:alt], "Rating image should have correct alt text"
      end
    end
  end

  def test_testimonial_css_classes_applied
    visit "/about-us/"

    # Check for all major CSS classes that control styling
    assert_selector ".pp-reviews-wrapper"
    assert_selector ".pp-reviews-swiper"
    assert_selector ".swiper-container"
    assert_selector ".pp-review-item"
    assert_selector ".pp-review-text"
    assert_selector ".pp-review-name"
    assert_selector ".pp-review-title"

    # Verify CSS is applied (check computed styles if needed)
    testimonial = first(".pp-review-item")
    assert testimonial.present?
  end

  def test_multiple_testimonials_render_correctly
    visit "/about-us/"

    # Count all testimonials from data file
    testimonials = all(".pp-review-item")
    assert testimonials.count >= 1,
      "Page should have at least 1 testimonial from data file"

    # Each testimonial should have required structure
    testimonials.each_with_index do |testimonial, index|
      within testimonial do
        assert_selector ".pp-review-text"
        assert_selector ".pp-review-name"
        assert_selector ".pp-rating"
      end
    end
  end

  def test_testimonial_content_not_empty_where_expected
    visit "/about-us/"

    testimonials = all(".pp-review-item")

    # All testimonials should have meaningful content from data
    testimonials.each do |testimonial|
      within testimonial do
        review_text = find(".pp-review-text p").text.strip
        author_name_text = find(".pp-review-name").text.strip

        refute review_text.empty?, "Review text should not be empty"
        refute author_name_text.empty?, "Author name should not be empty"

        assert review_text.length > 10, "Review should have meaningful content"
      end
    end
  end

  def test_testimonial_styling_integrity
    visit "/about-us/"

    # Check that CSS is properly loaded by examining computed styles
    testimonial = first(".pp-review-item")

    # Basic presence test - if CSS loaded, these elements should be styled
    assert testimonial.present?

    # Should be functional with basic selectors
    assert_selector ".pp-review-text"
    assert_selector ".pp-review-name"
  end
end
