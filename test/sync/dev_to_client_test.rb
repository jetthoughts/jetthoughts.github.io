# frozen_string_literal: true

require_relative "test_helper"
require_relative "../../bin/sync/dev_to_client"

class DevToClientTest < Minitest::Test
  def setup
    super
    @conn = Faraday.new do |builder|
      builder.adapter :test, @stubs = Faraday::Adapter::Test::Stubs.new
    end
    @client = DevToClient.new(http_client: @conn)
  end

  def test_get_articles_constructs_correct_url
    username = "testuser"
    page = 1
    articles = [{id: 1, title: "First Article"}]

    # Faraday test adapter requires exact URL match, so we need to use a dynamic stub
    @stubs.get(/./) do |env|
      if env.url.to_s.start_with?("#{DevToClient::BASE_URL}/articles") &&
        env.params["username"] == username &&
        env.params["page"] == page.to_s &&
        env.params["per_page"].to_i.between?(8999, 9999)
        [200, {}, articles.to_json]
      end
    end

    response = @client.get_articles(username, page)
    assert_equal articles.to_json, response.body
    @stubs.verify_stubbed_calls
  end

  def test_get_article_constructs_correct_url
    id = 123
    article = {id: 123, title: "Test Article"}

    @stubs.get("#{DevToClient::BASE_URL}/articles/#{id}") do |env|
      [200, {}, article.to_json]
    end

    response = @client.get_article(id)
    assert_equal article.to_json, response.body
    @stubs.verify_stubbed_calls
  end

  def test_download_sets_timeout
    url = "https://example.com/image.jpg"
    image_data = "fake-image-data"

    @stubs.get(url) do |env|
      assert env.params["timeout"]
      [200, {}, image_data]
    end

    response = @client.download(url)
    assert_equal image_data, response.body
    @stubs.verify_stubbed_calls
  end

  def test_download_handles_timeout_error
    url = "https://example.com/slow-image.jpg"

    @stubs.get(url) do
      raise Faraday::TimeoutError
    end

    assert_raises(Faraday::TimeoutError) do
      @client.download(url)
    end
    @stubs.verify_stubbed_calls
  end

  def test_update_article_sends_put_request
    content = "# Test"

    @stubs.put("https://dev.to/api/articles/123") do |env|
      assert_equal({article: {body_markdown: content}}.to_json, env.body)

      [200, {}, {edited_at: "202502181200"}.to_json]
    end

    response = @client.update_article(123, {body_markdown: content})
    assert_equal "202502181200", response["edited_at"]
    @stubs.verify_stubbed_calls
  end

  def test_handles_connection_failure
    username = "testuser"
    page = 1

    # Similar to get_articles test, we need a dynamic stub for connection failures
    @stubs.get(/.*/) do |env|
      raise Faraday::ConnectionFailed, "Connection failed"
    end

    assert_raises(Faraday::ConnectionFailed) do
      @client.get_articles(username, page)
    end

    @stubs.verify_stubbed_calls
  end
end
