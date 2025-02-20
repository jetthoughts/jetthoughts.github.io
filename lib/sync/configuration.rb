# frozen_string_literal: true

require "sync/logging"

module Sync
  class Configuration
    attr_accessor :logger
    attr_reader :working_dir

    def initialize
      self.working_dir = "content/blog"
      self.logger = Logging.logger
    end

    def working_dir=(value)
      raise ArgumentError unless File.directory?(value)
      @working_dir = value
    end
  end
end
