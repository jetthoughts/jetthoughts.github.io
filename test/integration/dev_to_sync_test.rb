require_relative '../../bin/dev_to_sync'
require_relative '../support/fake_http_client'
require 'minitest/autorun'

class DevToSyncTest < Minitest::Test
  WORKING_DIR = 'test/fixtures/content/blog'.freeze

  def setup
    fake_http_client = FakeHttpClient.new
    adapter = DevToAdapter.new(http_client: fake_http_client)
    @syncer = DevToSync.new(username: 'jetthoughts', adapter: adapter, working_dir: WORKING_DIR)
  end

  def teardown
    FileUtils.rm_rf(Dir.glob(WORKING_DIR))
  end

  def test_sync_downloads_articles
    refute File.exist?("#{WORKING_DIR}/develop-a-minimalistic-process/index.md")
    @syncer.sync
    assert File.exist?("#{WORKING_DIR}/develop-a-minimalistic-process/index.md")
  end
end
