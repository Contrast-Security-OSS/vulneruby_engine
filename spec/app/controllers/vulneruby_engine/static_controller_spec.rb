# frozen_string_literal: true

require 'capybara'
require 'rails_helper'

RSpec.describe('Static Controller', type: :request) do
  describe 'Static content', type: :system do
    # Set up teh Capybara & Selenium things
    let(:driver) do
      options = Selenium::WebDriver::Chrome::Options.new(capabilities: {
        'browserName': 'chrome',
      })

      driver = Selenium::WebDriver.for :chrome, desired_capabilities: options
      driver
    end

    before do
      # Selenium::WebDriver::Chrome.path = "/__t/chromium/latest/x64"
      # Capybara.register_driver :headless_chromium do |app|
      #   options = Selenium::WebDriver::Chrome::Options.new
      #   options.add_argument("--headless")
      #   options.add_argument("--no-sandbox")
      #   options.add_argument("--disable-dev-shm-usage")
      #   options.add_argument("--window-size=1280,900")
      #   Capybara::Selenium::Driver.new(app, browser: :chrome, capabilities: options)
      # end
      # Capybara.javascript_driver = :headless_chromium
      #
      # FROM https://github.com/nbulaj/ruby-chromedriver
      Capybara.register_driver(:headless_chrome) do |app|
        capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
          # Add 'no-sandbox' arg if you have an "unknown error: Chrome failed to start: exited abnormally"
          # @see https://github.com/SeleniumHQ/selenium/issues/4961
          chromeOptions: { args: %w[headless disable-gpu no-sandbox] }
        )

        Capybara::Selenium::Driver.new(app, browser: :chrome, desired_capabilities: capabilities)
      end

      Capybara.javascript_driver = :headless_chrome
    end

    after do
      driver.quit
    end

    it 'verifies selenium is working' do
      driver.visit '/vulneruby_engine/static/index'
      expect(driver.page).to have_content('Hello world')
    end
  end
end
