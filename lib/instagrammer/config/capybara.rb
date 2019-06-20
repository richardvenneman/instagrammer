# frozen_string_literal: true

Capybara.register_driver :headless_chrome do |app|
  capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
    chromeOptions: {
      args: %w(
        no-sandbox
        headless
        disable-dev-shm-usage
        disable-gpu
        window-size=1400,1400
      )
    }
  )

  Capybara::Selenium::Driver.new app,
    browser: :chrome,
    desired_capabilities: capabilities
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
