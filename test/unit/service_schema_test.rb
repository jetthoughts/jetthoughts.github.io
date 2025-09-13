require_relative "base_schema_test"

class ServiceSchemaTest < BaseSchemaTest
  def test_service_page_has_service_schema
    doc = parse_html_file("services/fractional-cto/index.html")
    schemas = extract_json_ld_schemas(doc)

    service_schema = schemas.find { |s| s["@type"] == "Service" }
    refute_nil service_schema, "Service schema not found"
  end

  def test_service_has_required_fields
    doc = parse_html_file("services/fractional-cto/index.html")
    service_data = schema_data(doc, "Service")

    refute_nil service_data, "Service schema not found"

    assert_schema_context(service_data)
    assert_equal "Service", service_data["@type"]
    assert_schema_fields(service_data, "name", "provider")
  end

  def test_service_has_valid_provider
    doc = parse_html_file("services/fractional-cto/index.html")
    schemas = extract_json_ld_schemas(doc)

    service_schema = schemas.find { |s| s["@type"] == "Service" }

    assert service_schema.key?("provider"), "Missing provider field"
    provider = service_schema["provider"]

    assert_includes provider["@type"], "Organization", "Provider not an Organization"
    assert provider.key?("@id"), "Provider missing @id reference"
  end
end
