# frozen_string_literal: true

require "minitest/autorun"
require "ostruct"

# NOTE: Reduce test time on retry
require_relative "../bin/sync/retryable"
Retryable::RETRY_CONFIG[:base_delay] = 0
