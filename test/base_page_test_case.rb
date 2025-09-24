require "minitest/autorun"
require "nokogiri"
require "json"

require "support/hugo_helpers"

Hugo.instance.precompile

class BasePageTestCase < Minitest::Test
  private

  def root_path
    Hugo.instance.destination_path
  end

  def parse_html_file(relative_path)
    html_path = "#{root_path}/#{relative_path}"
    assert File.exist?(html_path), "HTML file must exist: #{html_path}"

    content = File.read(html_path)
    refute content.empty?, "HTML file cannot be empty: #{html_path}"

    doc = Nokogiri::HTML(content)
    refute_nil doc, "Failed to parse HTML: #{html_path}"

    doc
  end

  def extract_json_ld_schemas(doc)
    doc.css('script[type="application/ld+json"]')
  end

  # ARCHITECTURAL: Find schema with fail-fast validation
  def find_schema_by_type(doc, schema_type)
    find_schema_elements_by_type(doc, schema_type).first
  end

  # ARCHITECTURAL: Get schema data with existence validation
  def schema_data(doc, schema_type)
    script = find_schema_by_type(doc, schema_type)
    return nil unless script # Caller must handle nil case with assertion

    JSON.parse(script.text)
  end

  def assert_schema_context(schema_data)
    assert_equal "https://schema.org", schema_data["@context"]
  end

  def assert_schema_fields(schema_data, *fields)
    fields.each do |field|
      assert schema_data.key?(field), "Missing #{field}"
    end
  end

  # Additional helper methods for common schema validation patterns
  def assert_valid_url(url, message = nil)
    assert_match %r{https?://.*}, url, message || "Should be a valid URL: #{url}"
  end

  def assert_valid_date(date_string, message = nil)
    assert_match(/\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}/, date_string,
      message || "Should be a valid ISO date: #{date_string}")
  end

  def assert_schema_type(schema_data, expected_type)
    assert_equal expected_type, schema_data["@type"], "Schema type should be #{expected_type}"
  end

  def assert_valid_json(json_string, context_message = "JSON")
    JSON.parse(json_string)
  rescue JSON::ParserError => e
    flunk "#{context_message} contains invalid JSON: #{e.message}"
  end

  def find_schemas_by_type(doc, schema_type)
    extract_json_ld_schemas(doc).map { |script| JSON.parse(script.text.strip) }.select { |schema| schema["@type"] == schema_type }
  end

  def find_schema_elements_by_type(doc, *schema_types)
    doc.css('script[type="application/ld+json"]').select do |script|
      schema_types.include?(JSON.parse(script.text.strip)['@type'])
    end
  end

  def assert_required_meta_tags(doc, *tag_selectors)
    tag_selectors.each do |selector|
      assert doc.css(selector).any?, "Missing required meta tag: #{selector}"
    end
  end
end
