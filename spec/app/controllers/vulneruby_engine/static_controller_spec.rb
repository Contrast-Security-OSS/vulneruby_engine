# frozen_string_literal: true

require 'capybara'
require 'rails_helper'

RSpec.describe('Static Controller', type: :request) do
  describe 'Static content', type: :system do
    # Set up teh Capybara & Selenium things
    # let(:driver) { Selenium::WebDriver.for :chrome }
    # let(:headless) { Headless.new }

    before do
      Capybara.register_driver :headless_chromium do |app|
        options = Selenium::WebDriver::Chrome::Options.new
        options.add_argument("--headless")
        options.add_argument("--no-sandbox")
        options.add_argument("--disable-dev-shm-usage")
        options.add_argument("--window-size=1280,900")
        Capybara::Selenium::Driver.new(app, browser: :chrome, capabilities: options)
      end
      Capybara.javascript_driver = :headless_chromium
    end

    # after do
    #   driver.quit
    #   headless.destroy
    # end

    it 'verifies selenium is working' do
      visit '/vulneruby_engine/static/index'
      expect(page).to have_content('Hello world')
    end
  end
end
