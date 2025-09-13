require "minitest/autorun"
require "nokogiri"
require "json"

class BreadcrumbSchemaTest < Minitest::Test
  def root_path
    ENV.fetch("HUGO_DEFAULT_PATH", "public-test")
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

  def test_blog_post_has_breadcrumb_list_schema
    doc = parse_html_file("blog/4-lines-speed-up-your-rails-test-suite-on-circleci/index.html")
    schemas = extract_json_ld_schemas(doc)

    refute_empty schemas, "No JSON-LD script tags found"

    breadcrumb_found = schemas.any? { |schema| schema["@type"] == "BreadcrumbList" }
    assert breadcrumb_found, "BreadcrumbList schema not found in JSON-LD scripts"
  end

  def test_breadcrumb_schema_has_valid_structure
    doc = parse_html_file("blog/4-lines-speed-up-your-rails-test-suite-on-circleci/index.html")
    breadcrumb_script = find_schema_by_type(doc, "BreadcrumbList")

    refute_nil breadcrumb_script, "BreadcrumbList script not found"

    json_data = JSON.parse(breadcrumb_script.text)

    assert_equal "https://schema.org", json_data["@context"]
    assert_equal "BreadcrumbList", json_data["@type"]
    assert json_data.key?("itemListElement"), "Missing itemListElement"
    refute_empty json_data["itemListElement"], "itemListElement should not be empty"
  end
end
