# frozen_string_literal: true

module Sync
  class Source
    class Lookup
      def initialize(&block)
        @sources = {}
      end

      def for(name)
        @sources.fetch(name)
      end

      def register(source)
        @sources[source.name] = source
      end

      def unregister(name)
        @sources.delete(name)
      end

      def source_names
        @sources.keys
      end
    end
  end
end
