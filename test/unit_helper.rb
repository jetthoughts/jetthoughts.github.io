# frozen_string_literal: true

ENV["SYNC_ENV"] = "test"
ENV["DEVTO_API_KEY"] = "fake-api-key"

require "minitest/autorun"
require "ostruct"
require "json"

# NOTE: Reduce test time on retry
require_relative "../bin/sync/retryable"
Retryable::RETRY_CONFIG[:base_delay] = 0
