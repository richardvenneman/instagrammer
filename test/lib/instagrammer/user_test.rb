# frozen_string_literal: true

require "test_helper"

class Instagrammer::UserTest < Minitest::Test
  def test_raises_with_nonexistent_user
    assert_raises Instagrammer::UserNotFound do
      Instagrammer::User.new(random_username)
    end
  end

  def test_constructor_returns_a_user_with_properties
    user = Instagrammer.new("richardvenneman")

    assert_kind_of Instagrammer::User, user
    assert_kind_of String, user.name
    assert_kind_of String, user.username
    assert_kind_of String, user.avatar
    assert_kind_of String, user.bio
    assert_kind_of String, user.url
    assert_kind_of Integer, user.follower_count
  end

  private
    def random_username
      ("a".."z").to_a.shuffle[16, 22].join
    end
end
