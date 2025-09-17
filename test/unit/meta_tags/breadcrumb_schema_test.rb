require_relative "../base_page_test"

class BreadcrumbSchemaTest < BasePageTestCase
  def test_blog_post_has_breadcrumb_list_schema
    doc = parse_html_file("blog/4-lines-speed-up-your-rails-test-suite-on-circleci/index.html")
    schemas = find_schemas_by_type(doc, "BreadcrumbList")

    refute_empty schemas, "No BreadcrumbList schemas found"
  end

  def test_breadcrumb_schema_has_valid_structure
    doc = parse_html_file("blog/4-lines-speed-up-your-rails-test-suite-on-circleci/index.html")
    breadcrumb_data = schema_data(doc, "BreadcrumbList")

    refute_nil breadcrumb_data, "BreadcrumbList script not found"

    assert_schema_context(breadcrumb_data)
    assert_equal "BreadcrumbList", breadcrumb_data["@type"]
    assert breadcrumb_data.key?("itemListElement"), "Missing itemListElement"
    refute_empty breadcrumb_data["itemListElement"], "itemListElement should not be empty"
  end
end
