require_relative '../../bin/dev_to_sync'
require_relative '../support/fake_http_client'
require 'minitest/autorun'

class DevToSyncTest < Minitest::Test
  def setup
    fake_http_client = FakeHttpClient.new
    adapter = DevToAdapter.new(http_client: fake_http_client)
    @syncer = DevToSync.new(username: 'jetthoughts', adapter: adapter)
  end

  def test_sync_downloads_articles
    @syncer.sync
    assert File.exist?('content/blog/develop-a-minimalistic-process/index.md')
  end
end
