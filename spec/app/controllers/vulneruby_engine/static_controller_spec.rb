# frozen_string_literal: true

require 'capybara'
require 'rails_helper'

RSpec.describe('Static Controller', type: :request) do
  describe 'Static content', type: :system do
    it 'verifies selenium is working' do
      visit '/vulneruby_engine/static/index'
      expect(page).to have_content('Hello world')
    end
  end
end
