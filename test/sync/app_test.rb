# frozen_string_literal: true

require_relative "test_helper"
require_relative "../../bin/sync/app"

class AppTest < Minitest::Test
  def setup
    super
    @app = App.new(working_dir: @temp_dir)
  end

  def test_initializes_with_storage
    assert_instance_of SyncStatusStorage, @app.storage, "Should initialize with a storage instance"
    assert_equal @temp_dir, @app.storage.sync_file_path.dirname.to_s, "Storage should use the correct working directory"
  end

  def test_dry_run_with_dry_flag
    app = App.new(args: ["--dry"])
    assert app.dry_run?, "Should be in dry run mode with --dry flag"
  end

  def test_dry_run_without_dry_flag
    app = App.new
    refute app.dry_run?, "Should not be in dry run mode without --dry flag"
  end

  def test_force_with_force_flag
    app = App.new(args: ["--force"])
    assert app.force?, "Should be in force mode with --force flag"
  end

  def test_force_with_short_force_flag
    app = App.new(args: ["-f"])
    assert app.force?, "Should be in force mode with -f flag"
  end

  def test_force_without_force_flag
    app = App.new
    refute app.force?, "Should not be in force mode without force flag"
  end
end
