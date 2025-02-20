# frozen_string_literal: true

require "test_helper"

require "support/test_http_client"
require "support/factories"

require "pathname"
require "yaml"

require "sync/app"
require "sync/configuration"
require "sync/article_updater"

class SyncTestCase < Minitest::Test
  # NOTE: Uncomment to run tests in parallel when it will be more than 1 minute
  # parallelize_me!

  def setup
    super
    working_dir = setup_temp_dir

    @articles = []
    @http_client = TestHttpClient.new(@articles)

    App.configure do |config|
      config.working_dir = working_dir
    end

    @app = App.new(fetcher: ArticleFetcher.new(@http_client))
  end

  def teardown
    teardown_temp_dir
    App.reset_config
    super
  end

  def setup_temp_dir
    @temp_dir = Pathname.new(Dir.mktmpdir)
  end

  def teardown_temp_dir
    FileUtils.remove_entry_secure(@temp_dir) if @temp_dir && Dir.exist?(@temp_dir)
  end

  # Factory method shortcuts
  def create_sync_file(dir, content)
    TestFactories::SyncStatus.create_file(dir, content)
  end

  def create_article(slug, content = "# Test Content")
    TestFactories::Article.create_page_bundle(@temp_dir, slug, content)
  end

  def create_article_with_metadata(slug, metadata = {}, content = "# Test Content")
    TestFactories::Article.create_with_metadata(@temp_dir, slug, metadata, content)
  end

  def read_markdown_metadata(...)
    TestFactories::Article.read_metadata(...)
  end

  def create_sync_status(...)
    TestFactories::SyncStatus.create(...)
  end

  def sample_article(...)
    TestFactories::Article.build_details(...)
  end
end
