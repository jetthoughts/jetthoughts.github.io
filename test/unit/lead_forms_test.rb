# frozen_string_literal: true

require_relative "../base_page_test_case"

# The lead-gen forms post to Google Forms, whose fields are addressed by
# opaque `entry.<id>` names supplied through site params
# (`[params.forms.*]` in config/_default/hugo.toml). Hugo renders a missing
# param as the empty string WITHOUT failing the build, so a renamed or
# dropped param yields a form that still renders, still matches the
# screenshot baselines pixel for pixel, and silently submits blank fields.
# The existing system tests visit these pages and screenshot them; nothing
# read the DOM until this file.
#
# Assertions are on shape (non-empty name, absolute https action), never on
# the entry ids or the endpoint URL - those are tunable config.
class LeadFormsTest < BasePageTestCase
  FUNNEL_PAGES = [
    "contact-us/index.html",
    "free-consultation/index.html"
  ].freeze

  def test_funnel_forms_post_to_an_absolute_endpoint
    FUNNEL_PAGES.each do |page|
      action = first_form(page)["action"].to_s

      assert_match %r{\Ahttps://\S+}, action,
        "#{page}: form action must be an absolute https endpoint (got #{action.inspect}). " \
        "An empty action posts back to the page itself and the lead is lost."
    end
  end

  def test_funnel_form_fields_all_carry_a_name
    FUNNEL_PAGES.each do |page|
      fields = submittable_fields(first_form(page))
      refute_empty fields, "#{page}: form renders no submittable fields"

      unnamed = fields.select { |field| field["name"].to_s.strip.empty? }

      assert_empty unnamed.map { |field| field["id"] || field.name },
        "#{page}: these fields render name=\"\" and submit nothing. " \
        "Check [params.forms.contact] in config/_default/hugo.toml - Hugo renders " \
        "a missing param as the empty string without failing the build."
    end
  end

  def test_funnel_forms_collect_the_expected_field_types
    FUNNEL_PAGES.each do |page|
      types = submittable_fields(first_form(page)).map { |field| field_type(field) }

      %w[text email tel textarea].each do |type|
        assert_includes types, type, "#{page}: form should collect a #{type} field"
      end
    end
  end

  def test_career_form_field_carries_a_name
    fields = submittable_fields(first_form("careers/index.html"))
    refute_empty fields, "careers page: form renders no submittable fields"

    unnamed = fields.select { |field| field["name"].to_s.strip.empty? }

    assert_empty unnamed.map { |field| field["id"] || field.name },
      "careers page: fields render name=\"\" - check [params.forms.career] " \
      "in config/_default/hugo.toml"
  end

  private

  def first_form(page)
    form = parse_html_file(page).css("form").first
    refute_nil form, "#{page} should render a form"
    form
  end

  # Submit buttons carry no name by design; everything else that posts does.
  def submittable_fields(form)
    form.css("input, textarea, select").reject do |field|
      %w[submit button image reset].include?(field["type"])
    end
  end

  def field_type(field)
    (field.name == "textarea") ? "textarea" : field["type"]
  end
end
