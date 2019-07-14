# frozen_string_literal: true

require "test_helper"

class Instagrammer::UtilsTest < Minitest::Test
  include Capybara::DSL
  include Instagrammer::Utils

  def test_invalid_get_page_status
    assert_equal :invalid, get_page_status
  end

  def test_private_user_get_page_status
    visit "https://www.instagram.com/pubity/"
    assert_equal :private, get_page_status
  end

  def test_invalid_user_get_page_status
    visit "https://www.instagram.com/champagnepapi/"
    assert_equal :invalid, get_page_status
  end

  def test_public_user_get_page_status
    visit "https://www.instagram.com/arianagrande/"
    assert_equal :public, get_page_status
  end
end
