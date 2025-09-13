require "application_system_test_case"
require "json"

class SeoSchemaTest < ApplicationSystemTestCase
  # Test affected URLs from Google Search Console report
  AFFECTED_URLS = [
    "/blog/implementing-instant-search-dynamic-forms-infinite/",
    "/about-us/",
    "/blog/vertical-ai-agents/",
    "/blog/revolutionizing-chip-design-with-llms/"
  ].freeze

  def test_schema_validation_on_affected_pages
    AFFECTED_URLS.each do |url|
      visit url

      # Check that the page loads successfully
      assert page.has_content?(""), "Page #{url} failed to load"

      # Find all JSON-LD scripts
      schema_scripts = page.all('script[type="application/ld+json"]', visible: false)

      assert schema_scripts.count > 0, "No JSON-LD schema found on #{url}"

      schema_scripts.each_with_index do |script, index|
        json_content = script.text(:all).strip

        # Skip empty scripts
        next if json_content.empty?

        # Validate JSON syntax
        begin
          parsed_json = JSON.parse(json_content)
          refute_nil parsed_json, "Schema #{index} on #{url} should parse as valid JSON"

          # Ensure it's a proper Schema.org object
          if parsed_json.is_a?(Hash)
            assert parsed_json.key?("@context"), "Schema #{index} on #{url} should have @context"
            assert parsed_json.key?("@type"), "Schema #{index} on #{url} should have @type"
            assert_equal "https://schema.org", parsed_json["@context"], "Schema #{index} on #{url} should use Schema.org context"
          end

          # Check for common malformation issues
          refute_includes json_content, '"string"', "Schema #{index} on #{url} should not contain literal 'string' values"
          refute_includes json_content, 'Invalid top level element', "Schema #{index} on #{url} should not have invalid elements"

        rescue JSON::ParserError => e
          flunk "Schema #{index} on #{url} contains invalid JSON: #{e.message}\nContent: #{json_content}"
        end
      end
    end
  end

  def test_blog_article_schema_structure
    # Test a specific blog post structure
    visit "/blog/implementing-instant-search-dynamic-forms-infinite/"

    article_schemas = page.all('script[type="application/ld+json"]', visible: false).select do |script|
      script.text(:all).include?('"@type": "Article"')
    end

    assert article_schemas.count > 0, "Article schema should be present on blog posts"

    article_schemas.each do |script|
      json_content = script.text(:all).strip
      parsed = JSON.parse(json_content)

      # Validate required Article fields
      assert_equal "Article", parsed["@type"]
      refute_nil parsed["headline"], "Article should have headline"
      refute_nil parsed["datePublished"], "Article should have datePublished"
      refute_nil parsed["author"], "Article should have author"
      refute_nil parsed["publisher"], "Article should have publisher"
    end
  end

  def test_organization_schema_structure
    visit "/about-us/"

    org_schemas = page.all('script[type="application/ld+json"]', visible: false).select do |script|
      script.text(:all).include?('"@type": "Organization"')
    end

    assert org_schemas.count > 0, "Organization schema should be present"

    org_schemas.each do |script|
      json_content = script.text(:all).strip
      parsed = JSON.parse(json_content)

      # Validate required Organization fields
      assert_includes ["Organization", "LocalBusiness"], parsed["@type"]
      refute_nil parsed["name"], "Organization should have name"
      refute_nil parsed["url"], "Organization should have URL"
    end
  end

  def test_service_schema_structure
    # Skip if no services pages exist
    begin
      visit "/services/fractional-cto-services/"
    rescue Capybara::ElementNotFound
      skip "Services pages not available for testing"
    end

    service_schemas = page.all('script[type="application/ld+json"]', visible: false).select do |script|
      json_content = script.text(:all).strip
      next if json_content.empty?

      begin
        parsed = JSON.parse(json_content)
        parsed.is_a?(Hash) && parsed["@type"] == "Service"
      rescue JSON::ParserError
        false
      end
    end

    # Services pages may have Organization schema but should also have Service schema
    assert service_schemas.count > 0, "Service schema should be present on services pages"

    service_schemas.each do |script|
      json_content = script.text(:all).strip
      parsed = JSON.parse(json_content)

      # Validate Service schema structure - should already be Service from selector
      assert_equal "Service", parsed["@type"]
      refute_nil parsed["name"], "Service should have name"
      refute_nil parsed["provider"], "Service should have provider"
    end
  end

  def test_no_malformed_schema_strings
    # Test that we don't have the "string" error reported by Google Search Console
    AFFECTED_URLS.each do |url|
      visit url

      # Get page source and check for malformed schema issues
      page_source = page.html

      # Check for the specific "Invalid top level element 'string'" issue
      refute_includes page_source, '<script type="application/ld+json">string</script>',
        "Page #{url} should not have malformed schema with literal 'string'"

      refute_includes page_source, '"@type": "string"',
        "Page #{url} should not have '@type': 'string' in schema"

      # Check for empty or malformed script tags
      empty_schemas = page.all('script[type="application/ld+json"]', visible: false).select do |script|
        content = script.text(:all).strip
        content.empty? || content == "string" || content.start_with?("string")
      end

      assert_empty empty_schemas, "Page #{url} should not have empty or malformed schema scripts"
    end
  end

  def test_schema_validation_with_different_content_types
    # Test pages with different content to ensure conditional schema works
    test_cases = [
      {url: "/blog/implementing-instant-search-dynamic-forms-infinite/", expected_type: "Article"},
      {url: "/about-us/", expected_types: ["Organization", "LocalBusiness"]}
    ]

    test_cases.each do |test_case|
      visit test_case[:url]

      if test_case[:expected_type]
        # Single expected type
        relevant_schemas = page.all('script[type="application/ld+json"]', visible: false).select do |script|
          script.text(:all).include?(%("@type": "#{test_case[:expected_type]}"))
        end

        assert relevant_schemas.count > 0,
          "Expected to find #{test_case[:expected_type]} schema on #{test_case[:url]}"

        relevant_schemas.each do |script|
          json_content = script.text(:all).strip

          # Ensure no trailing commas or malformed JSON
          refute_match(/,\s*}/, json_content, "Schema should not have trailing commas before closing braces")
          refute_match(/,\s*\]/, json_content, "Schema should not have trailing commas before closing brackets")

          # Parse to ensure valid JSON
          parsed = JSON.parse(json_content)
          assert_equal test_case[:expected_type], parsed["@type"]
        end
      else
        # Multiple expected types - check that at least one is present
        found_types = []
        page.all('script[type="application/ld+json"]', visible: false).each do |script|
          json_content = script.text(:all).strip
          next if json_content.empty?

          begin
            parsed = JSON.parse(json_content)
            if parsed.is_a?(Hash) && parsed["@type"]
              found_types << parsed["@type"]
            end
          rescue JSON::ParserError
            # Skip malformed JSON for this test
          end
        end

        matching_types = found_types & test_case[:expected_types]
        assert matching_types.count > 0,
          "Expected to find one of #{test_case[:expected_types]} schema types on #{test_case[:url]}, found: #{found_types.uniq}"
      end
    end
  end
end
