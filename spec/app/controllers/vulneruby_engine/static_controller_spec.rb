# frozen_string_literal: true

require 'capybara'
require 'rails_helper'

RSpec.describe('Static Controller', type: :request) do
  describe 'Static content', type: :system do
    # Set up teh Capybara & Selenium things
    let(:driver) do
      options = Selenium::WebDriver::Chrome::Options.new
      options.add_argument('--headless')
      options.add_argument('--disable-gpu')
      options.add_argument('--remote-debugging-port=9222')
      driver = Selenium::WebDriver.for :chrome, options: options
      # options = Selenium::WebDriver::Chrome::Options.new(binary: "/usr/bin/google-chrome")
      # options.add_argument('--headless')
      # options.add_argument('--no-sandbox')
      # # Workaround https://bugs.chromium.org/p/chromedriver/issues/detail?id=2650&q=load&sort=-id&colspec=ID%20Status%20Pri%20Owner%20Summary
      # options.add_argument('--disable-site-isolation-trials')
      # options.add_argument('--window-size=1920,1080')
      # options.add_argument('--enable-features=NetworkService,NetworkServiceInProcess')
      # options.add_preference('homepage', 'http://localhost:4445')
      # driver = Selenium::WebDriver.for :remote, options: options
      driver
    end
    # before do
    #   Capybara.register_driver :headless_chromium do |app|
    #     options = Selenium::WebDriver::Chrome::Options.new(binary: "/usr/bin/google-chrome")
    #     options.add_argument("--headless")
    #     options.add_argument('--disable-gpu')
    #     options.add_argument("--no-sandbox")
    #     options.add_argument("--disable-dev-shm-usage")
    #     options.add_argument("--window-size=1280,900")
    #     options.headless!
    #     Capybara::Selenium::Driver.new(app, browser: :chrome, capabilities: options)
    #   end
    #   Capybara.javascript_driver = :headless_chromium
    # end

    after do
      driver.quit
    end

    it 'verifies selenium is working' do
      driver.visit '/vulneruby_engine/static/index'
      expect(driver.page).to have_content('Hello world')
    end
  end
end
