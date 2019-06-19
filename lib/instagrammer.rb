# frozen_string_literal: true

require "capybara"
require "capybara/dsl"
require "webdrivers/chromedriver"

require "instagrammer/config/capybara"
require "instagrammer/post"
require "instagrammer/user"
require "instagrammer/version"

module Instagrammer
  class PrivateAccount < StandardError; end
  class UserInvalid < StandardError; end
  class UserNotFound < StandardError; end

  class PrivatePost < StandardError; end
  class PostNotFound < StandardError; end

  def self.new(username)
    User.new(username)
  end
end
