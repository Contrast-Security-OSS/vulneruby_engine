# frozen_string_literal: true

require 'capybara'
require 'rails_helper'

RSpec.describe('Static Controller', type: :request) do
  describe 'Static content', type: :system do
    # Set up teh Capybara & Selenium things
    before do
      directory ||= Pathname.new(Dir.mktmpdir)
      chromium = Capybara.drivers[:chromium]
      Capybara.drivers[:chromium] = lambda do |app|
        chromium.call(app).tap do |driver|
          driver.browser.download_path = directory
        end
      end
      Capybara.register_driver :chromium_headless do |app|
        Capybara::Selenium::Driver.load_selenium
        browser_options = ::Selenium::WebDriver::Chromium::Options.new.tap do |opts|
          opts.args << '--headless'
          opts.args << '--no-sandbox'
          opts.args << '--disable-site-isolation-trials'
          opts.args << '--enable-features=NetworkService,NetworkServiceInProcess'
        end

        browser_options.add_preference(:download, default_directory: directory)

        Capybara::Selenium::Driver.new(app, browser: :chromium, options: browser_options).tap do |driver|
          driver.browser.download_path = directory
        end
      end
    end

    it 'does whatever this is' do
      visit '/vulneruby_engine/static/index'
      expect(page).to have_content('Hello world')
    end
  end
end
