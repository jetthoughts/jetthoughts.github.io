# frozen_string_literal: true

module Sync
  class Source
    singleton_class.attr_accessor :default_source
    self.default_source = "dev_to"

    singleton_class.attr_accessor :sources
    self.sources = {}

    def self.for(name = nil, options = {})
      sources.fetch(name || self.default_source).new(options)
    end

    def self.register(name, klass)
      sources[name] = klass
    end

    def self.unregister(name)
      sources.delete(name)
    end

    def self.source_names
      sources.keys
    end
  end
end
