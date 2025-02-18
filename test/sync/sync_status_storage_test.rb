# frozen_string_literal: true

require "sync_test_case"
require "sync/sync_status_storage"

class SyncStatusStorageTest < SyncTestCase
  def setup
    super
    @storage = SyncStatusStorage.new(@temp_dir)
  end

  def test_creates_file_if_not_exists
    FileUtils.rm_f(File.join(@temp_dir, SyncStatusStorage::DEFAULT_SYNC_STATUS_FILE))

    @storage.ensure_file_exists

    assert File.exist?(File.join(@temp_dir, SyncStatusStorage::DEFAULT_SYNC_STATUS_FILE))
  end

  def test_loads_empty_hash_for_nonexistent_file
    assert_equal({}, @storage.load)
  end

  def test_loads_existing_sync_status
    sync_status = create_sync_status(
      edited_at: "2024-01-01",
      synced: false
    )
    create_sync_file(@temp_dir, sync_status)

    assert_equal sync_status, @storage.load
  end

  def test_saves_sync_status
    sync_status = create_sync_status(
      edited_at: "2024-02-01",
      synced: true
    )
    @storage.save(sync_status)

    assert_equal sync_status, YAML.load_file(File.join(@temp_dir, SyncStatusStorage::DEFAULT_SYNC_STATUS_FILE))
  end

  def test_handles_invalid_yaml
    File.write(File.join(@temp_dir, SyncStatusStorage::DEFAULT_SYNC_STATUS_FILE), "invalid: yaml: content: - ")
    assert_equal({}, @storage.load)
  end
end
