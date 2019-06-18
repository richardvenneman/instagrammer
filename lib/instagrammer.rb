# frozen_string_literal: true

require "capybara"
require "capybara/dsl"
require "webdrivers/chromedriver"

require "instagrammer/user"
require "instagrammer/version"

Capybara.register_driver :headless_chrome do |app|
  capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
    chromeOptions: { args: %w(headless no-sandbox disable-gpu window-size=1400,1400) }
  )

  Capybara::Selenium::Driver.new app,
    browser: :chrome,
    desired_capabilities: capabilities
end

Capybara.default_driver = :headless_chrome

module Instagrammer
  class UserNotFound < StandardError; end

  def self.new(username)
    User.new(username)
  end
end
