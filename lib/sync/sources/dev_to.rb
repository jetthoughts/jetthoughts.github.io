# frozen_string_literal: true

require "uri"
require "json"
require "sync/dev_to_client"
require "sync/sources/base"

module Sync
  module Sources
    class DevTo < Base
      USERNAME = "jetthoughts"

      def fetch_all
        with_retries(operation: "Fetching articles list") do
          response = client.get_articles(USERNAME, 0)
          if response.success?
            articles = JSON.parse(response.body)
            articles.map { |article| process_article(article) }
          else
            raise "Failed to fetch articles: #{response.body}"
          end
        end
      end

      def fetch(article_id)
        with_retries(operation: "Fetching article #{article_id}") do
          response = client.get_article(article_id)
          if response.success?
            article = JSON.parse(response.body)
            process_article(article)
          else
            raise "Failed to fetch an article: #{response.body}"
          end
        end
      end

      def fetch_asset(url)
        original_url = remove_cdn(url)
        with_retries(operation: "Downloading image from #{original_url}") do
          response = client.download(original_url)
          if response.success?
            response.body
          else
            raise "Failed to download #{url}: #{response.code} #{response.message}"
          end
        end
      end

      def update(article_id, data)
        client.update_article(article_id, data)
      end

      def need_to_update_remote?(article_data, article_sync_data)
        logger.debug("Checking if metadata is synced for article #{article_data["id"]}")

        return true unless article_sync_data

        !has_updated_canonical_url?(article_data["canonical_url"], article_sync_data[:slug]) ||
          !has_updated_meta_description?(article_data["description"], article_sync_data[:description])
      end

      def ext_from_image_url(image_url)
        File.extname(URI(remove_cdn(image_url)).path)
      end

      def remove_cdn(url)
        return url unless url.include?("https")
        encoded_url = "https" + url.to_s.split("https").last
        max_attempts = 5
        attempts = 0

        while encoded_url.include?("%") && attempts < max_attempts
          encoded_url = URI.decode_www_form_component(encoded_url)
          attempts += 1
        end

        encoded_url
      end

      private

      def build_client(options)
        options[:http_client] || DevToClient.new
      end

      def has_updated_canonical_url?(remote_canonical_url, expected_slug)
        return false if remote_canonical_url.nil?
        remote_canonical_url.split("/").last == expected_slug
      end

      def has_updated_meta_description?(remote_description, local_description)
        local_description.nil? || local_description.empty? || remote_description == local_description
      end

      def process_article(article)
        article["devto_slug"] = article["slug"]
        article["slug"] = dev_to_slug_without_salt(article["devto_slug"])
        article["source"] = name
        article
      end

      def dev_to_slug_without_salt(slug)
        slug.split("-")[0..-2].join("-")
      end
    end
  end
end
