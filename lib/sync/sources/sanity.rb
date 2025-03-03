# frozen_string_literal: true

require "sanity-ruby"
require "sync/sources/base"
require "uri"

Sanity.configure do |s|
  s.token = ENV["SANITY_API_TOKEN"]
  s.api_version = "v2021-10-21"
  s.project_id = "bic068w3"
  s.dataset = "production"
  s.use_cdn = false
end

module Sync
  module Sources
    class Sanity < Base
      def initialize(options = nil)
        super({name: "sanity"}.merge(options || {}))
      end

      def fetch_all
        with_retries(operation: "Fetching articles list from Sanity") do
          articles = run_filter_query
          return [] unless articles
          articles.map { |article| process_article(article) }
        rescue => e
          raise RetryableError, "Failed to fetch articles from Sanity: #{e.message}"
        end
      end

      def fetch(article_id)
        with_retries(operation: "Fetching article #{article_id} from Sanity") do
          article = run_filter_query(id: article_id)[0]
          process_article(article)
        rescue => e
          raise RetryableError, "Failed to fetch article #{article_id} from Sanity: #{e.message}"
        end
      end

      def fetch_asset(url)
        with_retries(operation: "Downloading image from #{url}") do
          response = Faraday.get(url, timeout: 60)
          if response.success?
            response.body
          else
            raise RetryableError, "Failed to download #{url}: #{response.code} #{response.message}"
          end
        end
      end

      def update(article_id, data)
        # noop
      end

      def need_to_update_remote?(*)
        false
      end

      def ext_from_image_url(image_url)
        File.extname(URI(image_url).path)
      end

      private

      def run_filter_query(id: nil)
        groq_query = if id
          <<~GROQ
            *[ _type =='post' && _id == "#{id}" ] {
              _id, title, description, _updatedAt, _rev, _createdAt,
              body,
              "slug": slug.current,
              "mainImageUrl": mainImage.asset->url

            }
          GROQ
        else
          <<~GROQ
            *[ _type =='post' && !(_id in path("drafts.*")) ]{
              _id,
              title,
              description,
              _updatedAt,
              _rev,
              _createdAt,
              "slug": slug.current,
              "mainImageUrl": mainImage.asset->url
            }
          GROQ
        end
        response = ::Sanity::Document.where(groq: groq_query, perspective: "published")
        raise "Failed to fetch articles from Sanity: #{response["error"]["description"]}" if response["error"]
        response["result"]
      end

      def build_client(options)
        options[:sanity_client] || ::Sanity::Document
      end

      def has_updated_canonical_url?(remote_slug, expected_slug)
        return false if remote_slug.nil?
        remote_slug == expected_slug
      end

      def has_updated_meta_description?(remote_description, local_description)
        local_description.nil? || local_description.empty? || remote_description == local_description
      end

      def process_article(article)
        return nil if article.nil?

        # Map Sanity document fields to expected structure
        {
          "id" => article["_id"],
          "title" => article["title"],
          "description" => article["description"],
          "slug" => article["slug"],
          "body_markdown" => article["body"],
          "cover_image" => article["mainImageUrl"],
          "created_at" => article["publishedAt"] || article["_createdAt"],
          "edited_at" => article["_updatedAt"],
          "tags" => article["categories"] || "",
          "canonical_url" => article["canonicalUrl"],
          "source" => name
        }
      end
    end
  end
end
