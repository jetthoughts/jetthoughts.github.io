require_relative "../support/fake_http_client"
require_relative "../../bin/sync/sync"
require "minitest/autorun"

class SyncWithDevToTest < Minitest::Test
  WORKING_DIR = "test/tmp/content/blog/".freeze
  SYNC_STATUS_FILE = "sync_status.yml".freeze
  FAKE_API_ARTICLE_1 = {
    slug: "recent-searches-sorting-hashes-how-they-are-connected-ruby-rails"
  }
  FAKE_API_ARTICLE_2 = {
    slug: "myth-or-reality-can-test-driven-development-in-agile-replace-qa-programming"
  }

  def setup
    ENV["DEVTO_API_KEY"] = "fake_api_key" # to avoid ArgumentError
    FileUtils.mkdir_p(WORKING_DIR) # to avoid Errno::ENOENT
  end

  def run_sync
    Sync.perform(http_client: FakeHttpClient.new, working_dir: WORKING_DIR)
  end

  def teardown
    FileUtils.rm_rf(Dir.glob(WORKING_DIR))
  end

  def prepare_sync_file_with_un_synced_article
    articles = {
      1879395 => {
        edited_at: "2023-10-23T00:00:00Z",
        slug: "recent-searches-sorting-hashes-how-they-are-connected-ruby-rails",
        synced: false
      },
      1877720 => {
        edited_at: "2024-10-23T15:44:11Z",
        slug: "myth-or-reality-can-test-driven-development-in-agile-replace-qa-programming",
        synced: true
      }
    }
    File.write("#{WORKING_DIR}#{SYNC_STATUS_FILE}", articles.to_yaml)
  end

  def sync_file_content
    YAML.safe_load_file("#{WORKING_DIR}#{SYNC_STATUS_FILE}", permitted_classes: [Time, Symbol])
  end

  def change_article_slug
    articles = {
      1879395 => {
        edited_at: "2023-10-23T00:00:00Z",
        slug: "changed_slug",
        synced: false
      },
      1877720 => {
        edited_at: "2024-10-23T15:44:11Z",
        slug: "myth-or-reality-can-test-driven-development-in-agile-replace-qa-programming",
        synced: true
      }
    }
    File.write("#{WORKING_DIR}#{SYNC_STATUS_FILE}", articles.to_yaml)
  end

  def change_article_meta_description
    articles = {
      1879395 => {
        edited_at: "2023-10-23T00:00:00Z",
        slug: "recent-searches-sorting-hashes-how-they-are-connected-ruby-rails",
        synced: false
      },
      1877720 => {
        edited_at: "2024-10-23T15:44:11Z",
        slug: "myth-or-reality-can-test-driven-development-in-agile-replace-qa-programming",
        description: "Custom description",
        synced: false
      }
    }
    File.write("#{WORKING_DIR}#{SYNC_STATUS_FILE}", articles.to_yaml)
  end

  def test_sync_script_create_yaml_status_file_on_first_run
    refute File.exist?("#{WORKING_DIR}#{SYNC_STATUS_FILE}")
    run_sync
    assert File.exist?("#{WORKING_DIR}#{SYNC_STATUS_FILE}")
  end

  def test_sync_script_fill_yaml_status_file
    run_sync

    assert_equal sync_file_content[1879395], {
      edited_at: "2024-10-23T15:44:11Z",
      slug: "recent-searches-sorting-hashes-how-they-are-connected-ruby-rails",
      synced: true
    }

    assert_equal sync_file_content[1877720], {
      edited_at: "2024-10-23T15:44:11Z",
      slug: "myth-or-reality-can-test-driven-development-in-agile-replace-qa-programming",
      synced: true
    }
  end

  def test_sync_only_unsynced_articles
    prepare_sync_file_with_un_synced_article

    assert_equal sync_file_content, {
      1879395 => {
        edited_at: "2023-10-23T00:00:00Z",
        slug: "recent-searches-sorting-hashes-how-they-are-connected-ruby-rails",
        synced: false
      },
      1877720 => {
        edited_at: "2024-10-23T15:44:11Z",
        slug: "myth-or-reality-can-test-driven-development-in-agile-replace-qa-programming",
        synced: true
      }
    }

    run_sync

    assert_equal sync_file_content[1879395], {
        edited_at: "2024-10-23T15:44:11Z",
        slug: "recent-searches-sorting-hashes-how-they-are-connected-ruby-rails",
        synced: true
      }

    assert_equal sync_file_content[1877720], {
        edited_at: "2024-10-23T15:44:11Z",
        slug: "myth-or-reality-can-test-driven-development-in-agile-replace-qa-programming",
        synced: true
    }
  end

  def test_sync_script_add_meta_information_to_article
    run_sync

    markdown_file = "#{WORKING_DIR}#{FAKE_API_ARTICLE_1[:slug]}/index.md"
    content = File.read(markdown_file)

    assert_includes content, "title: 'Recent Searches & Sorting Hashes: How They are Connected'"
    assert_includes content, "dev_to_url: https://dev.to/jetthoughts/recent-searches-sorting-hashes-how-they-are-connected-4965"
    assert_includes content, "description: In one of the applications, that we are developing, we needed to implement the storing of 10 last..."
    assert_includes content, "tags:"
    assert_includes content, "- ruby"
    assert_includes content, "- rails"
    assert_includes content, "- development"
    assert_includes content, "cover_image:"
  end

  def test_sync_add_article_markdown
    run_sync

    markdown_file = "#{WORKING_DIR}#{FAKE_API_ARTICLE_1[:slug]}/index.md"
    content = File.read(markdown_file)

    assert_includes content, "In one of the applications, that we are developing"
  end

  def test_sync_script_downloads_cover_image
    refute File.exist?("#{WORKING_DIR}#{FAKE_API_ARTICLE_1[:slug]}/cover.jpeg")
    run_sync
    assert File.exist?("#{WORKING_DIR}#{FAKE_API_ARTICLE_1[:slug]}/cover.jpeg")
  end

  def test_sync_script_downloads_article_images
    refute File.exist?("#{WORKING_DIR}#{FAKE_API_ARTICLE_1[:slug]}/file_0.jpeg")
    run_sync
    assert File.exist?("#{WORKING_DIR}#{FAKE_API_ARTICLE_1[:slug]}/file_0.jpeg")
  end

  def test_sync_script_replaces_images_with_local_files
    run_sync

    markdown_file = "#{WORKING_DIR}#{FAKE_API_ARTICLE_1[:slug]}/index.md"
    content = File.read(markdown_file)

    assert_includes content, "file_0.jpeg"
  end

  def test_sync_script_replaces_youtube_links
    run_sync

    markdown_file = "#{WORKING_DIR}#{FAKE_API_ARTICLE_1[:slug]}/index.md"
    content = File.read(markdown_file)

    assert_includes content, "{{< youtube id=0RKpf3rK57I loading=lazy start=30 >}}"
    refute_includes content, "{{< youtube 0RKpf3rK57I >}}"
  end

  def test_sync_script_apply_custom_slugs_from_file
    run_sync

    assert File.directory?("#{WORKING_DIR}#{FAKE_API_ARTICLE_1[:slug]}")
    assert File.directory?("#{WORKING_DIR}#{FAKE_API_ARTICLE_2[:slug]}")

    change_article_slug
    run_sync

    refute File.directory?("#{WORKING_DIR}#{FAKE_API_ARTICLE_1[:slug]}")
    assert File.directory?("#{WORKING_DIR}changed_slug")
    assert File.directory?("#{WORKING_DIR}#{FAKE_API_ARTICLE_2[:slug]}")
  end

  def test_sync_script_skip_updated_canonical_urls
    articles = {
      999 => {
        edited_at: "1995-10-23T15:44:11Z",
        slug: "synced-canonical-url-article",
        synced: false
      }
    }
    File.write("#{WORKING_DIR}#{SYNC_STATUS_FILE}", articles.to_yaml)

    assert_equal sync_file_content[999],
      {
        :edited_at=>"1995-10-23T15:44:11Z",
        :slug=>"synced-canonical-url-article",
        :synced=>false
      }

    run_sync

    # We check that edited_at wasn't changed, but the sync status changed.
    assert_equal sync_file_content[999],
      {
        :edited_at=>"1995-10-23T15:44:11Z",
        :slug=>"synced-canonical-url-article",
        :synced=>true
      }
  end

  def test_sync_script_set_custom_meta_description
    run_sync

    article_1 = File.read("#{WORKING_DIR}#{FAKE_API_ARTICLE_1[:slug]}/index.md")
    article_2 = File.read("#{WORKING_DIR}#{FAKE_API_ARTICLE_2[:slug]}/index.md")

    assert_includes article_1, "description: In one of the applications, that we are developing, we needed to implement the storing of 10 last..."
    assert_includes article_2, "description: Test-driven development (TDD) is a cornerstone of agile methodology. It involves creating unit..."

    change_article_meta_description
    run_sync

    article_1 = File.read("#{WORKING_DIR}#{FAKE_API_ARTICLE_1[:slug]}/index.md")
    article_2 = File.read("#{WORKING_DIR}#{FAKE_API_ARTICLE_2[:slug]}/index.md")

    assert_includes article_1, "description: In one of the applications, that we are developing, we needed to implement the storing of 10 last..."
    assert_includes article_2, "description: Custom description"
  end
end
