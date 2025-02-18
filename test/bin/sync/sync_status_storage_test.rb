require "minitest/autorun"
require "tmpdir"
require "fileutils"
require_relative "../../../bin/sync/sync_status_storage"

class SyncStatusStorageTest < Minitest::Test
  def setup
    @temp_dir = Dir.mktmpdir
    @storage = SyncStatusStorage.new(Pathname.new(@temp_dir))
  end

  def teardown
    FileUtils.remove_entry @temp_dir
  end

  def test_creates_file_if_not_exists
    refute File.exist?(@storage.sync_file_path)
    @storage.ensure_file_exists
    assert File.exist?(@storage.sync_file_path)
  end

  def test_loads_empty_hash_for_nonexistent_file
    assert_equal({}, @storage.load)
  end

  def test_loads_existing_sync_status
    content = { "123" => { edited_at: "2024-01-01", synced: false } }
    File.write(@storage.sync_file_path, content.to_yaml)
    
    assert_equal content, @storage.load
  end

  def test_saves_sync_status
    content = { "456" => { edited_at: "2024-02-01", synced: true } }
    @storage.save(content)
    
    assert_equal content, YAML.load_file(@storage.sync_file_path)
  end

  def test_handles_invalid_yaml
    File.write(@storage.sync_file_path, "invalid: yaml: content: - ")
    assert_equal({}, @storage.load)
  end
end
