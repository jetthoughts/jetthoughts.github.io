# frozen_string_literal: true

require "test_helper"

require "support/test_http_client"
require "support/factories"

require "pathname"
require "yaml"
require "logger"

require "sync/app"
require "sync/source"

Sync::Source.default_source = "test"

class SyncTestCase < Minitest::Test
  # NOTE: Uncomment to run tests in parallel when it will be more than 1 minute
  # parallelize_me!

  def setup
    working_dir = setup_temp_dir

    App.configure do |config|
      config.working_dir = working_dir
      config.logger = Logger.new(IO::NULL, level: Logger::DEBUG) unless ENV["DEBUG"]
    end

    @articles = []
    Sync::Source.register("test", create_test_source_for(@articles))
    @app = App.new
  end

  def create_test_source_for(articles = [])
    # Register a test version of the DevTo source that uses our test HTTP client
    Class.new(Sync::Sources::DevTo) do
      singleton_class.attr_accessor :articles

      def initialize(*)
        super(http_client: TestHttpClient.new(self.class.articles))
      end
    end.tap { _1.articles = articles }
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
    SyncStatusStorage.new(dir).save(content)
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

  def create_app(**)
    App.new(**)
  end
end
