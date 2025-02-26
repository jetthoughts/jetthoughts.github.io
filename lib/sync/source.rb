# frozen_string_literal: true

require "sync/sources/dev_to"
require "sync/sources/sanity"

module Sync
  class Source
    KLASSES_MAPPING = {
      "dev_to" => Sources::DevTo,
      "sanity" => Sources::Sanity
    }

    def self.for(name, options = {})
      KLASSES_MAPPING.fetch(name).new(options)
    end

    def register(name, klass)
      KLASSES_MAPPING[name] = klass
    end

    def self.all(*sources)
      sources = Array[sources].flatten
      sources = App.config.sources if sources.empty?

      active_sources = KLASSES_MAPPING.slice(*sources)
      active_sources.values.map { _1.new }
    end
  end
end
