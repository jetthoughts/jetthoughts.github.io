# frozen_string_literal: true

require "test_helper"

require "support/test_http_client"
require "support/factories"

require "pathname"
require "yaml"
require "logger"

require "sync/app"
require "sync/source"

App.configure do |config|
  config.logger = Logger.new(IO::NULL, level: Logger::DEBUG) unless ENV["DEBUG"]
end

class SyncTestCase < Minitest::Test
  # NOTE: Uncomment to run tests in parallel when it will be more than 1 minute
  # parallelize_me!

  def setup
    @working_dir = setup_temp_dir

    @articles = []
    @register = Sync::Source::Lookup.new.tap do
      it.register(Sync::Sources::Test.new(@articles, "test"))
    end

    @app = create_app
  end

  class Sync::Sources::Test < Sync::Sources::DevTo
    def initialize(articles = [], name = "test")
      super(name: name, http_client: TestHttpClient.new(articles))
    end
  end

  def teardown
    teardown_temp_dir
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
    TestFactories::Article.create_page_bundle(slug, content, app: @app)
  end

  def create_article_with_metadata(slug, metadata = {}, content = "# Test Content")
    TestFactories::Article.create_with_metadata(slug, metadata, content, app: @app)
  end

  def read_markdown_metadata(**)
    TestFactories::Article.read_metadata(app: @app, **)
  end

  def create_sync_status(...)
    TestFactories::SyncStatus.create(...)
  end

  def sample_article(...)
    TestFactories::Article.build_details(...)
  end

  def create_app(**)
    App.new(register: @register, working_dir: @working_dir, **)
  end

  def sync_records_count
    status = @app.status_storage.load
    status.size
  end

  def find_sync_record(record_id, statuses = nil, source: "test")
    status = statuses || @app.status_storage.load
    status[record_id] || status["#{source}_#{record_id}"]
  end
end
