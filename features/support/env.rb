require 'capybara'
require 'capybara/cucumber'
require 'capybara/dsl'
require 'selenium-webdriver'
require 'rspec'
require 'rspec/retry'
#require 'pry'


BROWSER = ENV['BROWSER']
puts(BROWSER)

Capybara.register_driver :selenium do |app|
  if BROWSER.eql?('chrome')
    Capybara::Selenium::Driver.new(app,
                                   :browser => :chrome,
                                   :desired_capabilities => Selenium::WebDriver::Remote::Capabilities.chrome(
                                       'chromeOptions' => {
                                           'args' => ["--start-maximized"]
                                       }
                                   )

    )
  elsif BROWSER.eql?('firefox')
    profile = Selenium::WebDriver::Firefox::Profile.new
    profile.native_events = true
    Capybara::Selenium::Driver.new(app, :browser => :firefox,
                                   :marionette => true , profile: profile)
  elsif BROWSER.eql?('internet_explorer')
    Capybara::Selenium::Driver.new(app, :browser => :internet_explorer)
  elsif BROWSER.eql?('safari')
    Capybara::Selenium::Driver.new(app, :browser => :safari)
  end
end

Capybara.configure do |config|
  config.app_host = 'http://bit.ly/watir-webdriver-demo'
  config.javascript_driver = :webkit
  config.default_driver = :selenium
  config.default_max_wait_time = 120
end

# RSpec.configure do |config|
#   # show retry status in spec process
#   config.verbose_retry = true
#   # Try twice (retry once)
#   config.default_retry_count = 2
#   # Only retry when Selenium raises Net::ReadTimeout
#   config.exceptions_to_retry = [Net::ReadTimeout]
#   # wait for ajax.
#   #config.include WaitForAjax, type: :feature
# end
