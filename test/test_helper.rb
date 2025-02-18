# frozen_string_literal: true

ENV["SYNC_ENV"] = "test"
ENV["DEVTO_API_KEY"] = "fake-api-key"

# Add lib directory to load path
lib_dir = File.expand_path("../lib", __dir__)
$LOAD_PATH.unshift(lib_dir) unless $LOAD_PATH.include?(lib_dir)

require "minitest/autorun"
require "logger"
require "ostruct"
require "json"
require "yaml"
require "fileutils"
require "tmpdir"
require "pathname"
require "faraday"

# NOTE: Reduce test time on retry
require "sync/retryable"
Retryable::RETRY_CONFIG[:base_delay] = 0

# Configure logging for tests
require "sync/logging"
Logging.configure(level: Logger::DEBUG)
Logging.logger = Logger.new(IO::NULL)
