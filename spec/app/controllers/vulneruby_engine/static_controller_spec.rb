# frozen_string_literal: true

require 'capybara'
require 'rails_helper'

RSpec.describe('Static Controller', type: :request) do
  describe 'Static content', type: :system do
    it 'verifies selenium is working' do
      begin
        visit '/vulneruby_engine/static/index'
      rescue Net::ReadTimeout => e
        puts "Timeout Error: #{e.message}"
        raise e
      end
      expect(page).to have_content('Hello world')
    end
  end
end
