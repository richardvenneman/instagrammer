# frozen_string_literal: true

require "test_helper"

class Instagrammer::PostTest < Minitest::Test
  def test_nonexistent_post
    assert_raises Instagrammer::PostNotFound do
      Instagrammer::Post.new("XXXXXX")
    end
  end

  def test_post
    post = Instagrammer::Post.new("Bys2eIABWFq")

    assert_kind_of String, post.image_url
    assert_kind_of Array, post.image_urls
    assert_kind_of Instagrammer::User, post.user
    assert_kind_of String, post.caption
    assert_kind_of DateTime, post.upload_date
    assert_kind_of Integer, post.comment_count
    assert_kind_of Integer, post.like_count

    image = post.image_urls.first
    assert_kind_of Hash, image
    assert_kind_of String, image[:url]
    assert_kind_of Integer, image[:width]
  end
end
