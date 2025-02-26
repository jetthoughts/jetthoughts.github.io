# frozen_string_literal: true

module Logging
  def logger
    @logger ||= App.config.logger
  end
end
