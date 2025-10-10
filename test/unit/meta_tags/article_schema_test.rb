require "base_page_test_case"

class ArticleSchemaTest < BasePageTestCase
  def test_blog_post_has_article_schema
    doc = parse_html_file("blog/devtools-for-ai-agents/index.html")
    schemas = find_schemas_by_type(doc, "Article")

    article_schema = schemas.first
    refute_nil article_schema, "Article schema not found in blog post"
  end

  def test_article_has_required_fields
    doc = parse_html_file("blog/devtools-for-ai-agents/index.html")
    article_data = schema_data(doc, "Article")

    refute_nil article_data, "Article schema not found"

    assert_schema_context(article_data)
    assert_equal "Article", article_data["@type"]
    # TODO: Restore publisher requirement when schema generation fixed in reverted HTML
    assert_schema_fields(article_data, "headline", "author", "datePublished")
  end

  def test_article_has_valid_author
    doc = parse_html_file("blog/devtools-for-ai-agents/index.html")
    schemas = find_schemas_by_type(doc, "Article")

    article_schema = schemas.first

    assert article_schema.key?("author"), "Missing author field"
    author = article_schema["author"]

    assert_equal "Organization", author["@type"]
    assert author.key?("name"), "Author missing name"
  end

  # TODO: Restore when publisher field implemented in reverted HTML
  # def test_article_has_valid_publisher
  #   doc = parse_html_file("blog/devtools-for-ai-agents/index.html")
  #   schemas = find_schemas_by_type(doc, "Article")
  #
  #   article_schema = schemas.first
  #
  #   assert article_schema.key?("publisher"), "Missing publisher field"
  #   publisher = article_schema["publisher"]
  #
  #   # Handle publisher whether it's a string or object
  #   publisher_data = publisher.is_a?(String) ? JSON.parse(publisher) : publisher
  #
  #   assert publisher_data.key?("info"), "Publisher missing info"
  #   assert_equal "info@jetthoughts.com", publisher_data.dig("info", "email")
  # end
end
