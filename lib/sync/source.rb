# frozen_string_literal: true

module Sync
  class Source
    singleton_class.attr_accessor :sources
    self.sources = {}

    def self.for(name = nil)
      sources.fetch(name)
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
