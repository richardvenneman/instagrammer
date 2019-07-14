# frozen_string_literal: true

require "test_helper"

class Instagrammer::PostTest < Minitest::Test
  def test_nonexistent_post
    user = Instagrammer::Post.new("XXXXXX")

    refute user.public?

    assert_raises Instagrammer::PostNotFound do
      user.caption
    end
  end

  def test_invalid_post
    post = Instagrammer::Post.new("BzFv6Z5oAUX")

    refute post.public?

    assert_raises Instagrammer::PostInvalid do
      post.caption
    end
  end

  def test_photo_post
    post = Instagrammer::Post.new("Bys2eIABWFq")

    assert post.public?
    assert post.photo?
    refute post.video?
    assert_kind_of String, post.image_url
    assert_kind_of Array, post.image_urls
    assert_kind_of Instagrammer::User, post.user
    assert_kind_of String, post.caption
    assert_kind_of DateTime, post.upload_date
    assert_kind_of Integer, post.comment_count
    assert_kind_of Integer, post.like_count
    assert_nil post.watch_count

    image = post.image_urls.first
    assert_kind_of Hash, image
    assert_kind_of String, image[:url]
    assert_kind_of Integer, image[:width]
  end

  def test_video_post
    post = Instagrammer::Post.new("Byx0Nd3A3qr")

    assert post.public?
    assert post.video?
    refute post.photo?
    assert_nil post.image_url
    assert_nil post.image_urls
    assert_kind_of Instagrammer::User, post.user
    assert_kind_of String, post.caption
    assert_kind_of DateTime, post.upload_date
    assert_kind_of Integer, post.comment_count
    assert_kind_of Integer, post.comment_count
    assert_nil post.like_count
    assert_kind_of Integer, post.watch_count
  end
end
