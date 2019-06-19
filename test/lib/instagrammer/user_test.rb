# frozen_string_literal: true

require "test_helper"

class Instagrammer::UserTest < Minitest::Test
  def test_nonexistent_user
    user = Instagrammer::User.new(random_username)

    refute user.valid?

    assert_raises Instagrammer::UserNotFound do
      user.name
    end
  end

  def test_private_account
    user = Instagrammer::User.new("pubity")

    refute user.valid?

    assert_raises Instagrammer::PrivateAccount do
      user.name
    end
  end

  def test_invalid_user
    user = Instagrammer::User.new("champagnepapi")

    refute user.valid?

    assert_raises Instagrammer::UserInvalid do
      user.name
    end
  end

  def test_user
    user = Instagrammer.new("arianagrande")

    assert user.valid?
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
