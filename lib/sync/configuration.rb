# frozen_string_literal: true

module Sync
  class Configuration
    attr_accessor :logger, :sources
    attr_reader :working_dir

    def initialize
      self.working_dir = "content/blog"
      self.sources = ["dev_to"]
    end

    def working_dir=(value)
      raise ArgumentError unless File.directory?(value)
      @working_dir = value
    end
  end
end
