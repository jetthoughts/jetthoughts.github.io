require "base_page_test_case"

# Re-enabled 2026-08-07: this file was commented out in full with a
# "restore when BreadcrumbList schema implemented in reverted HTML" TODO.
# The build has emitted BreadcrumbList on blog posts since then, so the
# TODO was stale and the file was dead code claiming coverage.
class BreadcrumbSchemaTest < BasePageTestCase
  BLOG_POST = "blog/4-lines-speed-up-your-rails-test-suite-on-circleci/index.html"

  def test_blog_post_has_breadcrumb_list_schema
    doc = parse_html_file(BLOG_POST)
    schemas = find_schemas_by_type(doc, "BreadcrumbList")

    refute_empty schemas, "No BreadcrumbList schemas found"
  end

  def test_breadcrumb_schema_has_valid_structure
    doc = parse_html_file(BLOG_POST)
    breadcrumb_data = schema_data(doc, "BreadcrumbList")

    refute_nil breadcrumb_data, "BreadcrumbList script not found"

    assert_schema_context(breadcrumb_data)
    assert_equal "BreadcrumbList", breadcrumb_data["@type"]
    assert breadcrumb_data.key?("itemListElement"), "Missing itemListElement"
    refute_empty breadcrumb_data["itemListElement"], "itemListElement should not be empty"
  end

  def test_breadcrumb_items_are_ordered_and_labelled
    doc = parse_html_file(BLOG_POST)
    items = schema_data(doc, "BreadcrumbList")["itemListElement"]

    items.each do |item|
      assert_equal "ListItem", item["@type"], "Breadcrumb entry should be a ListItem"
      refute_nil item["position"], "Breadcrumb entry missing position"
      refute item["name"].to_s.strip.empty?, "Breadcrumb entry missing a name"
    end

    positions = items.map { |item| item["position"] }
    assert_equal positions.sort, positions, "Breadcrumb positions should ascend"
  end
end
