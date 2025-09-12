# frozen_string_literal: true

require "minitest/autorun"
require "capybara/dsl" if defined?(Capybara)

require_relative "hugo_memory_server"

# Memory-based test case for fast content validation
class MemoryTestCase < Minitest::Test
  include Capybara::DSL if defined?(Capybara::DSL)

  def self.inherited(subclass)
    super
    subclass.extend(ClassMethods)
  end

  module ClassMethods
    def memory_server
      @memory_server ||= HugoMemoryServer.new
    end

    def setup_hugo_memory
      memory_server.start
    end

    def teardown_hugo_memory
      memory_server.stop
    end
  end

  def memory_server
    self.class.memory_server
  end

  def setup
    super
    self.class.setup_hugo_memory
  end

  def teardown
    super
    # Keep server running between tests for performance
    # Only stop in at_exit hook
  end
end

# Auto-cleanup on exit
at_exit do
  HugoMemoryServerSingleton.instance.stop if defined?(HugoMemoryServerSingleton)
end
