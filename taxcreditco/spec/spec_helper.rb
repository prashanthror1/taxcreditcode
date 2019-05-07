require 'capybara'
require 'capybara/rspec'
require 'selenium-webdriver'
require 'site_prism'

@browser = Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(app, :browser => :chrome)
end

Capybara.current_driver = :selenium
Capybara.default_driver = :selenium
Capybara.app_host = 'https://taxcreditco.com'
