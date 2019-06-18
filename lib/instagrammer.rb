# frozen_string_literal: true

require "capybara"
require "capybara/dsl"
require "webdrivers/chromedriver"

require "instagrammer/config/capybara"
require "instagrammer/user"
require "instagrammer/version"

module Instagrammer
  class UserNotFound < StandardError; end

  def self.new(username)
    User.new(username)
  end
end