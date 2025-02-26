# lib/sync/sources/base.rb
module Sync
  module Sources
    class Base
      include Logging
      include Retryable

      attr_reader :client

      def initialize(options = {})
        @client = build_client(options)
      end

      def fetch_all
        raise NotImplementedError
      end

      def fetch(_id)
        raise NotImplementedError
      end

      def fetch_asset(_url)
        raise NotImplementedError
      end

      def update(_id, _data)
        raise NotImplementedError
      end

      private

      def build_client(_options)
        raise NotImplementedError
      end
    end
  end
end
