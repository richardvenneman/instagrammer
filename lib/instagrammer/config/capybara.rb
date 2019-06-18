# frozen_string_literal: true

Capybara.register_driver :headless_chrome do |app|
  capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
    chromeOptions: { args: %w(headless no-sandbox disable-gpu window-size=1400,1400) }
  )

  Capybara::Selenium::Driver.new app,
    browser: :chrome,
    desired_capabilities: capabilities
end

Capybara.default_driver = :headless_chrome

Capybara.add_selector(:json_ld) do
  xpath { ".//script[@type='application/ld+json']" }
end