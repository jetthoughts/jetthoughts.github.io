require_relative "base_schema_test"

class OrganizationSchemaTest < BaseSchemaTest
  def test_organization_schema_exists
    doc = parse_html_file("about-us/index.html")
    schemas = extract_json_ld_schemas(doc)

    org_schema = schemas.find { |schema| schema["@type"] == "Organization" }

    refute_nil org_schema, "Organization schema not found"
  end

  def test_organization_has_required_fields
    doc = parse_html_file("about-us/index.html")
    org_data = schema_data(doc, "Organization")

    refute_nil org_data, "Organization schema not found"

    assert_schema_context(org_data)
    assert_schema_fields(org_data, "name", "url")
    assert_equal "JetThoughts", org_data["name"]
  end

  def test_organization_has_contact_point
    doc = parse_html_file("about-us/index.html")
    schemas = extract_json_ld_schemas(doc)

    org_schema = schemas.find { |schema| schema["@type"] == "Organization" }

    assert org_schema.key?("contactPoint"), "Missing contactPoint"
    refute_empty org_schema["contactPoint"], "contactPoint should not be empty"
  end
end
