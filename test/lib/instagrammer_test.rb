# frozen_string_literal: true

require "test_helper"

class InstagrammerTest < Minitest::Test
  def test_that_it_has_a_version_number
    assert Instagrammer::VERSION
  end

  def test_constructor_returns_a_user
    assert_kind_of Instagrammer::User, Instagrammer.new("richardvenneman")
  end
end
