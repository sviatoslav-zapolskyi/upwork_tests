require 'capybara/cucumber'

Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end

Capybara.javascript_driver = :chrome

Capybara.configure do |config|
  config.run_server = false
  config.default_max_wait_time = 10 # seconds
  config.default_driver = :selenium
  config.app_host = 'https://www.upwork.com'
end
