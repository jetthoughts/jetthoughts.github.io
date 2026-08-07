require "base_page_test_case"

# seo/faq-schema.html is emitted sitewide from baseof.html and carries FAQ
# content on the service pages. It had no test: malformed JSON-LD fails
# silently (Google drops the rich result, the page still renders fine), so
# a regression here is invisible to both the build and the screenshot gate.
#
# The partial also de-duplicates questions within a page and guards against
# running twice - both are behaviors worth pinning.
class FaqSchemaTest < BasePageTestCase
  FAQ_PAGE = "services/fractional-cto/index.html"

  def test_service_page_has_faq_schema
    doc = parse_html_file(FAQ_PAGE)
    schemas = find_schemas_by_type(doc, "FAQPage")

    refute_empty schemas, "FAQPage schema not found on a page with faqs frontmatter"
  end

  def test_faq_schema_has_required_fields
    faq = schema_data(parse_html_file(FAQ_PAGE), "FAQPage")

    refute_nil faq, "FAQPage schema not found"

    assert_schema_context(faq)
    assert_equal "FAQPage", faq["@type"]
    assert_schema_fields(faq, "mainEntity")
    refute_empty faq["mainEntity"], "FAQPage should carry at least one Question"
  end

  def test_every_question_has_a_non_empty_accepted_answer
    faq = schema_data(parse_html_file(FAQ_PAGE), "FAQPage")

    faq["mainEntity"].each do |question|
      assert_equal "Question", question["@type"], "FAQ entry should be a Question"
      refute question["name"].to_s.strip.empty?, "Question missing its name"

      answer = question["acceptedAnswer"]
      refute_nil answer, "Question #{question["name"].inspect} has no acceptedAnswer"
      assert_equal "Answer", answer["@type"], "acceptedAnswer should be an Answer"
      refute answer["text"].to_s.strip.empty?,
        "Question #{question["name"].inspect} has an empty answer - " \
        "an empty answer disqualifies the whole FAQ rich result"
    end
  end

  # The partial normalizes each question to a slug and skips repeats. A
  # duplicate question inside one FAQPage is a Google validation error.
  def test_questions_are_unique_within_a_page
    faq = schema_data(parse_html_file(FAQ_PAGE), "FAQPage")
    names = faq["mainEntity"].map { |question| question["name"].to_s.downcase.strip }

    assert_equal names.uniq, names, "FAQPage contains duplicate questions"
  end

  # baseof.html renders the partial once, and the partial sets a Scratch
  # flag so a second call is a no-op. Two FAQPage blocks on one page is
  # also a validation error.
  def test_only_one_faq_schema_block_per_page
    schemas = find_schemas_by_type(parse_html_file(FAQ_PAGE), "FAQPage")

    assert_equal 1, schemas.size, "Expected exactly one FAQPage block per page"
  end

  # Every service page that declares faqs in frontmatter must emit the
  # schema - a template guard that silently stops matching would otherwise
  # drop rich results across the whole section with nothing turning red.
  def test_all_service_pages_with_faq_frontmatter_emit_the_schema
    missing = service_pages_with_faq_frontmatter.reject do |page|
      find_schemas_by_type(parse_html_file(page), "FAQPage").any?
    end

    assert_empty missing, "service pages declaring faqs but emitting no FAQPage schema"
  end

  private

  def service_pages_with_faq_frontmatter
    Dir[File.expand_path("../../../content/services/*/index.md", __dir__)].filter_map do |source|
      body = File.read(source, encoding: "bom|utf-8")
      next unless body =~ /^\s*faqs:/ || body =~ /^\s*faq:/

      "services/#{File.basename(File.dirname(source))}/index.html"
    end
  end
end
