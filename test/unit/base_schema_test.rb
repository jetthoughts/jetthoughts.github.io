require "minitest/autorun"
require "nokogiri"
require "json"

class BaseSchemaTest < Minitest::Test
  private

  def root_path
    ENV.fetch("HUGO_DEFAULT_PATH", "_dest/public-test")
  end

  def parse_html_file(relative_path)
    html_path = "#{root_path}/#{relative_path}"
    Nokogiri::HTML(File.read(html_path))
  end

  def extract_json_ld_schemas(doc)
    doc.css('script[type="application/ld+json"]').map do |script|
      JSON.parse(script.text)
    end
  end

  def find_schema_by_type(doc, schema_type)
    doc.css('script[type="application/ld+json"]').find do |script|
      parsed = JSON.parse(script.text)
      parsed["@type"] == schema_type
    end
  end

  def schema_data(doc, schema_type)
    script = find_schema_by_type(doc, schema_type)
    return nil unless script
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
    assert_match /\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}/, date_string,
                message || "Should be a valid ISO date: #{date_string}"
  end

  def assert_schema_type(schema_data, expected_type)
    assert_equal expected_type, schema_data["@type"], "Schema type should be #{expected_type}"
  end

  def find_schemas_by_type(doc, schema_type)
    extract_json_ld_schemas(doc).select { |schema| schema["@type"] == schema_type }
  end

  def assert_required_meta_tags(doc, *tag_selectors)
    tag_selectors.each do |selector|
      assert doc.css(selector).any?, "Missing required meta tag: #{selector}"
    end
  end
end
