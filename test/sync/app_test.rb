# frozen_string_literal: true

require_relative "test_helper"
require_relative "../../bin/sync/app"

class AppTest < Minitest::Test
  def setup
    super
    @app = App.new
  end

  def test_default_configuration
    assert_equal false, @app.dry_run?
    assert_equal false, @app.force?
    assert_equal "content/blog/", @app.working_dir
    assert_equal "sync_status.yml", @app.sync_status_file
    assert_instance_of Logger, @app.logger
  end

  def test_configuration_with_args
    app = App.new(args: %w[--dry -f])
    assert_equal true, app.dry_run?
    assert_equal true, app.force?
  end

  def test_configuration_with_custom_working_dir
    app = App.new(working_dir: "custom/path/")
    assert_equal "custom/path/", app.working_dir
  end

  def test_configuration_with_custom_sync_status_file
    app = App.new(sync_status_file: "custom_sync.yml")
    assert_equal "custom_sync.yml", app.sync_status_file
  end

  def test_configuration_with_custom_logger
    custom_logger = Logger.new(StringIO.new)
    app = App.new(logger: custom_logger)
    assert_equal custom_logger, app.logger
  end

  def test_parse_args_with_long_and_short_options
    app = App.new(args: %w[--force --dry])
    assert app.force?
    assert app.dry_run?

    app = App.new(args: %w[-f --dry])
    assert app.force?
    assert app.dry_run?
  end
end
