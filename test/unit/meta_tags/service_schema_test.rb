require "base_page_test_case"

# Re-enabled 2026-08-07: this file was commented out in full with a
# "restore when Service schema implemented in reverted HTML" TODO. The
# build has emitted Service on the service pages since then, so the TODO
# was stale and the file was dead code claiming coverage.
class ServiceSchemaTest < BasePageTestCase
  SERVICE_PAGE = "services/fractional-cto/index.html"

  def test_service_page_has_service_schema
    doc = parse_html_file(SERVICE_PAGE)
    schemas = find_schemas_by_type(doc, "Service")

    refute_empty schemas, "Service schema not found"
  end

  def test_service_has_required_fields
    doc = parse_html_file(SERVICE_PAGE)
    service_data = schema_data(doc, "Service")

    refute_nil service_data, "Service schema not found"

    assert_schema_context(service_data)
    assert_equal "Service", service_data["@type"]
    assert_schema_fields(service_data, "name", "provider")
  end

  def test_service_has_valid_provider
    doc = parse_html_file(SERVICE_PAGE)
    service_schema = find_schemas_by_type(doc, "Service").first

    refute_nil service_schema, "Service schema not found"
    assert service_schema.key?("provider"), "Missing provider field"

    provider = service_schema["provider"]
    assert_includes provider["@type"], "Organization", "Provider not an Organization"
    refute provider["name"].to_s.strip.empty?, "Provider missing a name"
  end
end
