require_relative "../base_page_test_case"

class CdnImageProxyTest < BasePageTestCase
  # Tests that production builds serve blog images via wsrv.nl CDN proxy.
  # The test helper builds with --environment production, so CDN is enabled.

  def setup
    @blog_posts = Dir.glob("#{root_path}/blog/*/index.html")
      .reject { |f| f.end_with?("blog/index.html") }

    refute_empty @blog_posts, "Expected compiled blog posts in blog/*/index.html"
  end

  def test_markdown_images_use_cdn_picture_element
    post = require_post_with_picture_element
    doc = Nokogiri::HTML(File.read(post))
    picture = doc.css("picture").first

    sources = picture.css("source")
    assert sources.length >= 2, "Picture should have at least webp and jpeg sources"

    sources.each do |source|
      srcset = source["srcset"]
      assert_includes srcset, "wsrv.nl", "Source srcset should use wsrv.nl CDN"
      assert_match(/w=\d+/, srcset, "CDN URLs should include width parameter")
      assert_match(/output=(webp|jpeg)/, srcset, "CDN URLs should include output format")
      assert_match(/q=\d+/, srcset, "CDN URLs should include quality parameter")
      assert_match(/\d+w/, srcset, "Srcset should include width descriptors")
    end

    img = picture.css("img").first
    refute_nil img, "Picture element must have fallback img"
    assert_includes img["src"], "wsrv.nl", "Fallback img should use wsrv.nl CDN"
    assert_equal "lazy", img["loading"], "Images should have lazy loading"
  end

  def test_cdn_urls_have_correct_sizes
    post = require_post_with_picture_element
    doc = Nokogiri::HTML(File.read(post))
    srcset = doc.css("picture source").first["srcset"]

    %w[w=400 w=800 w=1200 w=1600].each do |size|
      assert_includes srcset, size, "Srcset should include #{size}"
    end
  end

  def test_cdn_urls_proxy_through_wsrv
    post = require_post_with_picture_element
    doc = Nokogiri::HTML(File.read(post))
    srcset = doc.css("picture source").first["srcset"]

    assert_match(/url=.*\/content\//, srcset, "CDN URLs should proxy source content path")
  end

  def test_blog_thumbnails_use_cdn
    doc = parse_html_file("blog/index.html")

    thumbnail_imgs = doc.css(".blog-post img, .post-image img, article img")
    cdn_thumbnails = thumbnail_imgs.select { |img| img["src"]&.include?("wsrv.nl") }

    refute_empty cdn_thumbnails, "Blog listing thumbnails should use wsrv.nl CDN"

    cdn_thumbnails.each do |img|
      src = img["src"]
      assert_match(/output=jpg/, src, "Thumbnails should request JPG format")
      assert_match(/q=90/, src, "Thumbnails should use q=90 quality")
    end
  end

  def test_og_images_use_cdn
    post_with_og = @blog_posts.find do |path|
      content = File.read(path)
      content.include?("og:image") && content.include?("wsrv.nl")
    end
    refute_nil post_with_og, "At least one blog post should have CDN og:image"

    doc = Nokogiri::HTML(File.read(post_with_og))
    og_url = doc.css("meta[property='og:image']").first["content"]

    assert_includes og_url, "wsrv.nl", "OG image should use wsrv.nl CDN"
    assert_match(/w=1200/, og_url, "OG image should be 1200px wide")
    assert_match(/h=630/, og_url, "OG image should be 630px tall")
    assert_match(/fit=cover/, og_url, "OG image should use cover fit")
  end

  def test_picture_element_has_sizes_attribute
    post = require_post_with_picture_element
    doc = Nokogiri::HTML(File.read(post))
    source = doc.css("picture source").first

    assert source["sizes"], "Source should have sizes attribute"
    assert_includes source["sizes"], "48rem", "Sizes should reference max content width"
  end

  def test_images_preserve_dimensions
    post = require_post_with_picture_element
    doc = Nokogiri::HTML(File.read(post))
    img = doc.css("picture img").first

    assert img["width"], "Image should have width attribute for CLS prevention"
    assert img["height"], "Image should have height attribute for CLS prevention"
  end

  private

  def require_post_with_picture_element
    @_post_with_picture ||= begin
      post = @blog_posts.find do |path|
        content = File.read(path)
        content.include?("<picture>") && content.include?("wsrv.nl")
      end
      refute_nil post, "Expected at least one blog post with CDN <picture> element"
      post
    end
  end
end
