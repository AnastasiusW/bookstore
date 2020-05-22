RSpec.configure do |_config|
  Capybara.register_driver :site_prism do |app|
    capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
      chromeOptions: { args: %w[headless enable-features=NetworkService,NetwortServiceInProcess] }
    )
    Capybara::Selenium::Driver.new(app, browser: :chrome, desired_capabilities: capabilities)
  end
end
Capybara.default_driver = :site_prism
Capybara.javascript_driver = :site_prism

#Capybara.ignore_hidden_elements = false
Capybara.default_max_wait_time = 5
