# frozen_string_literal: true

require "sync/sources/dev_to"
require "sync/sources/sanity"

module Sync
  class Source
    KLASSES_MAPPING = {
      "dev_to" => Sources::DevTo,
      "sanity" => Sources::Sanity
    }

    singleton_class.attr_accessor :default_source
    self.default_source = "dev_to"

    singleton_class.attr_accessor :sources
    self.sources = KLASSES_MAPPING.dup

    def self.for(name = nil, options = {})
      sources.fetch(name || self.default_source).new(options)
    end

    def self.register(name, klass)
      sources[name] = klass
    end
  end
end
