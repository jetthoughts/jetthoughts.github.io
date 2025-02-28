# frozen_string_literal: true

module Sync
  class Source
    singleton_class.attr_accessor :default_source
    self.default_source = "dev_to"

    singleton_class.attr_accessor :sources
    self.sources = {}

    def self.for(name = nil)
      raise name if name == "dev_to"
      sources.fetch(name || self.default_source)
    end

    def self.register(source)
      sources[source.name] = source
    end

    def self.unregister(name)
      sources.delete(name)
    end

    def self.source_names
      sources.keys
    end
  end
end
