require "base_page_test_case"

class TestimonialShortcodeTest < BasePageTestCase
  # Unit tests for testimonial shortcode functionality and rendering
  # Tests rendered HTML output from public-test directory (no server required)

  def test_testimonial_renders_with_all_attributes
    # Visit about page which has testimonials partial
    doc = parse_html_file("about-us/index.html")

    # Verify testimonials section renders properly (data-driven testimonials)
    assert doc.css("#testimonials").any?, "About page should have testimonials section"
    assert doc.css(".pp-reviews-wrapper").any?, "Should have testimonials wrapper"

    # Verify testimonial slides exist (from data/testimonials.yaml)
    assert doc.css(".pp-review-item").any?, "Should have testimonial items"

    # Verify testimonial content structure
    assert doc.css(".pp-review-text p").any?, "Should have testimonial text"

    # Verify author information displays
    assert doc.css(".pp-review-name").any?, "Should have author names"
    assert doc.css(".pp-review-title").any?, "Should have author titles"
  end

  def test_testimonial_content_from_data_file
    doc = parse_html_file("about-us/index.html")

    # Find the first testimonial from data/testimonials.yaml
    first_testimonial = doc.css(".pp-review-item").first
    assert first_testimonial, "Should have at least one testimonial"

    # Check for testimonial content (should have Bruno Wozniak testimonial)
    assert first_testimonial.css(".pp-review-text p").any?, "First testimonial should have text"

    # Verify author information from data file
    assert first_testimonial.css(".pp-review-name").any?, "Should have author name"
    assert first_testimonial.css(".pp-review-title").any?, "Should have author title"

    # Verify rating display
    rating_imgs = first_testimonial.css(".pp-rating img[alt='five stars']")
    assert rating_imgs.any?, "Should have rating images with correct alt text"
  end

  def test_testimonial_carousel_functionality
    doc = parse_html_file("about-us/index.html")

    # Verify Swiper carousel structure
    assert doc.css(".swiper-container").any?, "Should have swiper container"
    assert doc.css(".swiper-wrapper").any?, "Should have swiper wrapper"

    # Should have multiple testimonial slides from data
    testimonials = doc.css(".pp-review-item")
    assert testimonials.count >= 1, "Should have at least 1 testimonial from data file"

    # Verify each testimonial has proper structure
    first_testimonial = testimonials.first
    assert first_testimonial.css(".pp-review-text").any?, "First testimonial should have text section"
    assert first_testimonial.css(".pp-review-name").any?, "First testimonial should have name"
    assert first_testimonial.css(".pp-review-title").any?, "First testimonial should have title"
  end

  def test_careers_page_testimonial
    doc = parse_html_file("careers/index.html")

    # The careers page should render successfully
    page_text = doc.text
    assert page_text.include?("Looking for a Team to Take You to the Next Level?"),
      "Careers page should have expected heading"

    # Verify testimonial from frontmatter renders
    # Based on careers.html layout, testimonial content is in a specific section
    testimonial_paragraphs = doc.css(".fl-rich-text p")
    testimonial_text = testimonial_paragraphs.map(&:text).join(" ")
    assert testimonial_text.include?("The best company I worked for"),
      "Should have testimonial text from frontmatter"

    assert page_text.include?("Current Employee (3+ Years)"),
      "Should have employee tenure info"
    assert page_text.include?("Ruby on Rails Developer at JetThoughts"),
      "Should have job title info"
  end

  def test_testimonial_data_structure
    doc = parse_html_file("about-us/index.html")

    # Verify testimonials are loaded from data file
    testimonials = doc.css(".pp-review-item")
    assert testimonials.count >= 1, "Should have testimonials from data file"

    testimonials.each_with_index do |testimonial, index|
      # Each testimonial should have required structure from data
      assert testimonial.css(".pp-review-text p").any?,
        "Testimonial #{index} should have review text"
      assert testimonial.css(".pp-review-name").any?,
        "Testimonial #{index} should have author name"

      # Verify content is not empty (from actual data)
      review_text = testimonial.css(".pp-review-text p").first&.text&.strip
      author_name = testimonial.css(".pp-review-name").first&.text&.strip

      refute review_text&.empty?, "Review text should not be empty for testimonial #{index}"
      refute author_name&.empty?, "Author name should not be empty for testimonial #{index}"
    end
  end

  def test_testimonial_accessibility_attributes
    doc = parse_html_file("about-us/index.html")

    first_testimonial = doc.css(".pp-review-item").first
    assert first_testimonial, "Should have first testimonial"

    # Check for proper semantic HTML
    cite_elements = first_testimonial.css("cite.pp-review-cite")
    assert cite_elements.any?, "Should have cite elements for semantic HTML"

    # Check rating images have proper alt text
    rating_imgs = first_testimonial.css(".pp-rating img")
    if rating_imgs.any?
      rating_imgs.each do |img|
        alt_text = img["alt"]
        assert alt_text && !alt_text.empty?, "Rating image should have alt attribute"
        assert_equal "five stars", alt_text, "Rating image should have correct alt text"
      end
    end
  end

  def test_testimonial_css_classes_applied
    doc = parse_html_file("about-us/index.html")

    # Check for all major CSS classes that control styling
    assert doc.css(".pp-reviews-wrapper").any?, "Should have reviews wrapper class"
    assert doc.css(".pp-reviews-swiper").any?, "Should have reviews swiper class"
    assert doc.css(".swiper-container").any?, "Should have swiper container class"
    assert doc.css(".pp-review-item").any?, "Should have review item class"
    assert doc.css(".pp-review-text").any?, "Should have review text class"
    assert doc.css(".pp-review-name").any?, "Should have review name class"
    assert doc.css(".pp-review-title").any?, "Should have review title class"
  end

  def test_multiple_testimonials_render_correctly
    doc = parse_html_file("about-us/index.html")

    # Count all testimonials from data file
    testimonials = doc.css(".pp-review-item")
    assert testimonials.count >= 1,
      "Page should have at least 1 testimonial from data file"

    # Each testimonial should have required structure
    testimonials.each_with_index do |testimonial, index|
      assert testimonial.css(".pp-review-text").any?,
        "Testimonial #{index} should have text section"
      assert testimonial.css(".pp-review-name").any?,
        "Testimonial #{index} should have name section"
      assert testimonial.css(".pp-rating").any?,
        "Testimonial #{index} should have rating section"
    end
  end

  def test_testimonial_content_not_empty_where_expected
    doc = parse_html_file("about-us/index.html")

    testimonials = doc.css(".pp-review-item")

    # All testimonials should have meaningful content from data
    testimonials.each_with_index do |testimonial, index|
      review_text = testimonial.css(".pp-review-text p").first&.text&.strip
      author_name_text = testimonial.css(".pp-review-name").first&.text&.strip

      refute review_text&.empty?, "Review text should not be empty for testimonial #{index}"
      refute author_name_text&.empty?, "Author name should not be empty for testimonial #{index}"

      if review_text
        assert review_text.length > 10, "Review should have meaningful content for testimonial #{index}"
      end
    end
  end

  def test_testimonial_styling_integrity
    doc = parse_html_file("about-us/index.html")

    # Basic presence test - structural elements should be present
    testimonials = doc.css(".pp-review-item")
    assert testimonials.any?, "Should have testimonial items"

    # Should have functional selectors for styling
    assert doc.css(".pp-review-text").any?, "Should have review text elements"
    assert doc.css(".pp-review-name").any?, "Should have review name elements"
  end
end
