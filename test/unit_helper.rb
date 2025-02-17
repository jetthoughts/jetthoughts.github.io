# frozen_string_literal: true

ENV["SYNC_ENV"] = "test"
ENV["DEVTO_API_KEY"] = "fake-api-key"

require "minitest/autorun"
require "logger"
require "ostruct"
require "json"

# NOTE: Reduce test time on retry
require_relative "../bin/sync/retryable"
Retryable::RETRY_CONFIG[:base_delay] = 0

# Configure logging for tests
require_relative "../bin/sync/logging"
Logging.configure(level: Logger::WARN)
Logging.logger = Logger.new(IO::NULL)
