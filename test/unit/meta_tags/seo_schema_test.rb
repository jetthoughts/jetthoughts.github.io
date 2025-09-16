require_relative "../base_page_test"
require "json"

# ARCHITECTURAL: Inherit from refactored BaseSchemaTest with strict assertions
class SeoSchemaTest < BasePageTest
  # Unit tests for SEO schema validation and structured data
  # Tests rendered HTML output from public-test directory (no server required)

  # Test affected URLs from Google Search Console report
  AFFECTED_URLS = [
    "blog/implementing-instant-search-dynamic-forms-infinite/index.html",
    "about-us/index.html",
    "blog/vertical-ai-agents/index.html",
    "blog/revolutionizing-chip-design-with-llms/index.html"
  ].freeze

  def test_schema_validation_on_affected_pages
    AFFECTED_URLS.each do |file_path|
      # Skip if file doesn't exist (some blog posts may not be published)
      next unless File.exist?(File.join(root_path, file_path))

      doc = parse_html_file(file_path)

      # Find all JSON-LD scripts
      schema_scripts = doc.css('script[type="application/ld+json"]')
      assert schema_scripts.count > 0, "No JSON-LD schema found on #{file_path}"

      schema_scripts.each_with_index do |script, index|
        json_content = script.text.strip

        # ARCHITECTURAL: Use skip instead of silent continue
        if json_content.empty?
          skip "Schema #{index} on #{file_path} is empty - might indicate template issue"
        end

        # ARCHITECTURAL: Use strict validation method that fails fast
        parsed_json = assert_valid_json(json_content, "Schema #{index} on #{file_path}")

        # Ensure it's a proper Schema.org object
        assert parsed_json.is_a?(Hash),
          "Schema #{index} on #{file_path} should be a Hash, got #{parsed_json.class}"

        assert parsed_json.key?("@context"),
          "Schema #{index} on #{file_path} must have @context"
        assert parsed_json.key?("@type"),
          "Schema #{index} on #{file_path} must have @type"
        assert_equal "https://schema.org", parsed_json["@context"],
          "Schema #{index} on #{file_path} must use Schema.org context"

        # Check for common malformation issues
        refute_includes json_content, '"string"',
          "Schema #{index} on #{file_path} contains literal 'string' placeholder"
        refute_includes json_content, "Invalid top level element",
          "Schema #{index} on #{file_path} contains invalid elements"
      end
    end
  end

  def test_blog_article_schema_structure
    blog_file = "blog/implementing-instant-search-dynamic-forms-infinite/index.html"
    return unless File.exist?(File.join(root_path, blog_file))

    doc = parse_html_file(blog_file)

    article_schemas = find_schema_elements_by_type(doc, 'Article')

    assert article_schemas.count > 0, "Article schema should be present on blog posts"

    article_schemas.each_with_index do |script, index|
      json_content = script.text.strip
      parsed = JSON.parse(json_content)

      # Validate required Article fields
      assert_equal "Article", parsed["@type"], "Schema #{index} should be Article type"
      refute_nil parsed["headline"], "Article should have headline"
      refute_nil parsed["datePublished"], "Article should have datePublished"
      refute_nil parsed["author"], "Article should have author"
      refute_nil parsed["publisher"], "Article should have publisher"
    end
  end

  def test_organization_schema_structure
    doc = parse_html_file("about-us/index.html")

    org_schemas = find_schema_elements_by_type(doc, 'Organization', 'LocalBusiness')

    assert org_schemas.count > 0, "Organization schema should be present"

    org_schemas.each_with_index do |script, index|
      json_content = script.text.strip
      parsed = JSON.parse(json_content)

      # Validate required Organization fields
      assert %w[Organization LocalBusiness].include?(parsed["@type"]),
        "Schema #{index} should be Organization or LocalBusiness type"
      refute_nil parsed["name"], "Organization should have name"
      refute_nil parsed["url"], "Organization should have URL"
    end
  end

  def test_service_schema_structure
    service_file = "services/fractional-cto/index.html"
    return unless File.exist?(File.join(root_path, service_file))

    doc = parse_html_file(service_file)

    service_schemas = doc.css('script[type="application/ld+json"]').select do |script|
      content = script.text
      begin
        parsed = JSON.parse(content.strip)
        parsed.is_a?(Hash) && (parsed["@type"] == "Service" || parsed["@type"] == "Organization")
      rescue JSON::ParserError
        false
      end
    end

    # Services pages may have Organization schema but should also have Service schema
    assert service_schemas.count > 0, "Service or Organization schema should be present on services pages"

    service_schemas.each_with_index do |script, index|
      json_content = script.text.strip
      parsed = JSON.parse(json_content)

      # Validate schema structure (could be Service or Organization)
      if parsed["@type"] == "Service"
        refute_nil parsed["name"], "Service should have name"
        refute_nil parsed["provider"], "Service should have provider"
      elsif parsed["@type"] == "Organization"
        refute_nil parsed["name"], "Organization should have name"
        refute_nil parsed["url"], "Organization should have URL"
      end
    end
  end

  def test_no_malformed_schema_strings
    # Test that we don't have the "string" error reported by Google Search Console
    AFFECTED_URLS.each do |file_path|
      next unless File.exist?(File.join(root_path, file_path))

      doc = parse_html_file(file_path)
      page_html = doc.to_html

      # Check for the specific "Invalid top level element 'string'" issue
      refute_includes page_html, '<script type="application/ld+json">string</script>',
        "Page #{file_path} should not have malformed schema with literal 'string'"

      refute_includes page_html, '"@type": "string"',
        "Page #{file_path} should not have '@type': 'string' in schema"

      # Check for empty or malformed script tags
      empty_schemas = doc.css('script[type="application/ld+json"]').select do |script|
        content = script.text.strip
        content.empty? || content == "string" || content.start_with?("string")
      end

      assert_empty empty_schemas, "Page #{file_path} should not have empty or malformed schema scripts"
    end
  end

  def test_schema_validation_with_different_content_types
    # Test pages with different content to ensure conditional schema works
    test_cases = [
      {
        file: "blog/implementing-instant-search-dynamic-forms-infinite/index.html",
        expected_type: "Article"
      },
      {
        file: "about-us/index.html",
        expected_types: %w[Organization LocalBusiness]
      }
    ]

    test_cases.each do |test_case|
      next unless File.exist?(File.join(root_path, test_case[:file]))

      doc = parse_html_file(test_case[:file])

      if test_case[:expected_type]
        # Single expected type
        relevant_schemas = find_schema_elements_by_type(doc, test_case[:expected_type])

        assert relevant_schemas.count > 0,
          "Expected to find #{test_case[:expected_type]} schema on #{test_case[:file]}"

        relevant_schemas.each_with_index do |script, index|
          json_content = script.text.strip

          # Ensure no trailing commas or malformed JSON
          refute_match(/,\s*}/, json_content,
            "Schema #{index} should not have trailing commas before closing braces")
          refute_match(/,\s*\]/, json_content,
            "Schema #{index} should not have trailing commas before closing brackets")

          # Parse to ensure valid JSON
          parsed = JSON.parse(json_content)
          assert_equal test_case[:expected_type], parsed["@type"]
        end
      else
        # Multiple expected types - check that at least one is present
        found_types = []
        doc.css('script[type="application/ld+json"]').each do |script|
          json_content = script.text.strip
          next if json_content.empty?

          # ARCHITECTURAL: Fail fast on invalid JSON instead of silently skipping
          parsed = assert_valid_json(json_content, "Schema type collection for #{test_case[:page]}")
          if parsed.is_a?(Hash) && parsed["@type"]
            found_types << parsed["@type"]
          end
        end

        matching_types = found_types & test_case[:expected_types]
        assert matching_types.count > 0,
          "Expected to find one of #{test_case[:expected_types]} schema types on #{test_case[:file]}, found: #{found_types.uniq}"
      end
    end
  end

  def test_json_ld_script_attributes
    doc = parse_html_file("index.html")

    json_ld_scripts = doc.css('script[type="application/ld+json"]')
    assert json_ld_scripts.count > 0, "Homepage should have JSON-LD structured data"

    json_ld_scripts.each_with_index do |script, index|
      # Verify proper script attributes
      assert_equal "application/ld+json", script["type"],
        "Script #{index} should have correct type attribute"

      # Content should not be empty
      content = script.text.strip
      refute content.empty?, "Script #{index} should not be empty"

      # Should be valid JSON
      # ARCHITECTURAL: Use strict validation helper
      parsed = assert_valid_json(content, "Schema script #{index}")
      assert parsed.is_a?(Hash) || parsed.is_a?(Array),
        "Script #{index} must be a JSON object or array, got #{parsed.class}"
    end
  end

  def test_breadcrumb_schema_when_present
    # Test breadcrumb schema on a page that likely has it
    doc = parse_html_file("about-us/index.html")

    breadcrumb_schemas = doc.css('script[type="application/ld+json"]').select do |script|
      script.text.include?("BreadcrumbList")
    end

    # Breadcrumb schema is optional, but if present should be valid
    if breadcrumb_schemas.any?
      breadcrumb_schemas.each_with_index do |script, index|
        json_content = script.text.strip
        parsed = JSON.parse(json_content)

        assert_equal "BreadcrumbList", parsed["@type"],
          "Breadcrumb schema #{index} should have BreadcrumbList type"
        assert parsed["itemListElement"].is_a?(Array),
          "Breadcrumb schema #{index} should have itemListElement array"

        parsed["itemListElement"].each_with_index do |item, item_index|
          assert item["@type"] == "ListItem",
            "Breadcrumb item #{item_index} should be ListItem type"
          assert item["position"], "Breadcrumb item #{item_index} should have position"
          assert item["name"], "Breadcrumb item #{item_index} should have name"
        end
      end
    end
  end
end
