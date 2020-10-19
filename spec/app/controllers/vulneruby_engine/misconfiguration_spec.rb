# frozen_string_literal: true

RSpec.describe('Misconfiguration Controller', type: :request) do
  describe 'GET /misconfiguration' do
    it 'renders the misconfiguration page' do
      get '/vulneruby_engine/misconfiguration'
      expect(response).to(render_template(:index))
    end
  end

  describe 'POST /misconfiguration' do
    it 'renders the misconfiguration result page' do
      post '/vulneruby_engine/misconfiguration'
      expect(response).to(render_template(:run))
      expect(response.body).to(include(
                                   'Cache-Control',
                                   'Pragma',
                                   'Expires',
                                   'X-XSS-Protection',
                                   'X-Frame-Options',
                                   'X-Content-Type-Options',
                                   'X-Content-Security-Policy'))
    end
  end
end
