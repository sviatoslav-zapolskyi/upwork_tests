require 'capybara/cucumber'

Capybara.javascript_driver = :selenium

Capybara.configure do |config|
  config.run_server = false
  config.default_max_wait_time = 10 # seconds
  config.default_driver = :selenium
  config.app_host = 'https://www.upwork.com'
end

Dir[File.join(File.dirname(__FILE__), '../pages/*.rb')].each { |f| require f }
