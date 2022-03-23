# frozen_string_literal: true

require 'capybara'
require 'rails_helper'

RSpec.describe('Static Controller', type: :request) do
  describe 'Static content', type: :system do
    # Set up teh Capybara & Selenium things
    # let(:driver) do
    #   options = Selenium::WebDriver::Chrome::Options.new(capabilities: {
    #     'browserName': 'chrome',
    #   })
    #
    #   driver = Selenium::WebDriver.for :chrome, desired_capabilities: options
    #   driver
    # end
    #
    # before do
    #   Selenium::WebDriver::Chrome.path = "/__t/chromium/latest/x64"
    #   Capybara.register_driver :headless_chromium do |app|
    #     options = Selenium::WebDriver::Chrome::Options.new
    #     options.add_argument("--headless")
    #     options.add_argument("--no-sandbox")
    #     options.add_argument("--disable-dev-shm-usage")
    #     options.add_argument("--window-size=1280,900")
    #     Capybara::Selenium::Driver.new(app, browser: :chrome, capabilities: options)
    #   end
    #   Capybara.javascript_driver = :headless_chromium
    # end
    #
    # after do
    #   driver.quit
    # end

    it 'verifies selenium is working' do

      chrome = Capybara.drivers[:chrome]
      Capybara.drivers[:chrome] = lambda do |app|
        chrome.call(app).tap do |driver|
          driver.browser.download_path = DownloadHelpers.directory
        end
      end
      Capybara.register_driver :chrome_headless do |app|
        Capybara::Selenium::Driver.load_selenium
        browser_options = ::Selenium::WebDriver::Chrome::Options.new.tap do |opts|
          opts.args << '--headless'
          opts.args << '--disable-gpu' if Gem.win_platform?
          opts.args << '--no-sandbox'
          # Workaround https://bugs.chromium.org/p/chromedriver/issues/detail?id=2650&q=load&sort=-id&colspec=ID%20Status%20Pri%20Owner%20Summary
          opts.args << '--disable-site-isolation-trials'
          opts.args << '--window-size=1920,1080'
          opts.args << '--enable-features=NetworkService,NetworkServiceInProcess'
        end

        # Chrome >= 77
        browser_options.add_preference(:download, default_directory: DownloadHelpers.directory)

        Capybara::Selenium::Driver.new(app, browser: :chrome, options: browser_options).tap do |driver|
          # Chrome < 77
          driver.browser.download_path = DownloadHelpers.directory
        end
      end

      visit '/vulneruby_engine/static/index'
      expect(page).to have_content('Hello world')
    end
  end
end
