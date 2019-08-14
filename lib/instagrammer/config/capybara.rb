# frozen_string_literal: true

require "capybara"
require "capybara/dsl"
require "webdrivers/chromedriver"

Selenium::WebDriver::Chrome.path = ENV["GOOGLE_CHROME_SHIM"] if ENV["GOOGLE_CHROME_SHIM"].present?

Capybara.register_driver :headless_chrome do |app|
  options = Selenium::WebDriver::Chrome::Options.new(
    args: %w(
      disable-gpu
      headless
      no-sandbox
      disable-dev-shm-usage
      window-size=1400,1400
    )
  )

  Capybara::Selenium::Driver.new app,
    browser: :chrome,
    options: options
end

Capybara.default_driver = :headless_chrome

Capybara.add_selector(:meta_description) do
  xpath { ".//meta[@name='description']" }
end

Capybara.add_selector(:json_ld) do
  xpath { ".//script[@type='application/ld+json']" }
end

Capybara.add_selector(:image) do
  xpath { ".//img[@srcset]" }
end

Capybara.add_selector(:post_link) do
  xpath { ".//a[starts-with(@href, '/p/')]" }
end
