# frozen_string_literal: true

require_relative "test_helper"
require_relative "../../bin/sync/sync"

class SyncTest < Minitest::Test
  def setup
    super
    @articles = [sample_article]
    @http_client = TestHttpClient.new(@articles)
    @app = App.new(working_dir: @temp_dir)
    @sync = Sync.new(app: @app, http_client: @http_client)
  end

  def test_perform_in_dry_run_mode
    create_sync_file(@temp_dir, create_sync_status(synced: false))
    app = App.new(args: ["--dry"], working_dir: @temp_dir)
    sync = Sync.new(app: app, http_client: @http_client)

    sync.perform

    sync_data = YAML.load_file(File.join(@temp_dir, "sync_status.yml"))
    refute sync_data[1][:synced], "Article should not be marked as synced in dry run mode"
    assert_equal 0, @http_client.update_requests.size, "No update requests should be made in dry run mode"
  end

  def test_perform_with_force
    create_sync_file(@temp_dir, create_sync_status(synced: true))
    app = App.new(args: ["--force"], working_dir: @temp_dir)
    sync = Sync.new(app: app, http_client: @http_client)

    sync.perform

    sync_data = YAML.load_file(File.join(@temp_dir, "sync_status.yml"))
    assert sync_data[1][:synced], "Article should be marked as synced in force mode"
  end
end
