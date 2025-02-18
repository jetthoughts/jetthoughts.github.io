# frozen_string_literal: true

require "logger"

module Logging
  class << self
    def configure(level: Logger::INFO)
      @logger ||= Logger.new($stdout).tap { |l| l.level = level }
    end

    def logger
      @logger ||= configure
    end

    def logger=(new_logger)
      @logger = new_logger
    end
  end

  def logger
    @logger ||= Logging.logger
  end

  protected

  attr_writer :logger
end
