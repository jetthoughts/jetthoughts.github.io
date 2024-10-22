require_relative '../../bin/dev_to_sync'
require_relative '../support/fake_http_client'
require 'minitest/autorun'

class DevToSyncTest < Minitest::Test
  WORKING_DIR = 'test/fixtures/content/blog'.freeze
  FAKE_API_ARTICLE = {
    slug: "recent-searches-sorting-hashes-how-they-are-connected-4965"
  }

  def setup
    fake_http_client = FakeHttpClient.new
    adapter = DevToAdapter.new(http_client: fake_http_client)
    @syncer = DevToSync.new(username: 'jetthoughts', adapter: adapter, working_dir: WORKING_DIR)
  end

  def teardown
    FileUtils.rm_rf(Dir.glob(WORKING_DIR))
  end

  def test_sync_downloads_articles
    refute File.exist?("#{WORKING_DIR}/#{FAKE_API_ARTICLE[:slug]}/index.md")
    @syncer.sync
    assert File.exist?("#{WORKING_DIR}/#{FAKE_API_ARTICLE[:slug]}/index.md")
  end

  def test_sync_add_meta_information_to_article
    @syncer.sync

    markdown_file = "#{WORKING_DIR}/#{FAKE_API_ARTICLE[:slug]}/index.md"
    content = File.read(markdown_file)

    assert_includes content, 'title: "Test Article"'
    assert_includes content, 'description: "This is a test article."'
    assert_includes content, 'tags:'
    assert_includes content, '  - test'
    assert_includes content, '  - article'
    assert_includes content, 'cover_image: "https://example.com/cover.jpg"'
    assert_includes content, 'This is the body of the test article.'
  end
end
