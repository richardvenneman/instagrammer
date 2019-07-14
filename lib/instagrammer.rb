# frozen_string_literal: true

require "instagrammer/version"
require "instagrammer/utils"
require "instagrammer/config/capybara"
require "instagrammer/post"
require "instagrammer/user"

module Instagrammer
  class PrivateAccount < StandardError; end
  class UserInvalid < StandardError; end
  class UserNotFound < StandardError; end

  class PrivatePost < StandardError; end
  class PostInvalid < StandardError; end
  class PostNotFound < StandardError; end

  def self.new(username)
    User.new(username)
  end
end
