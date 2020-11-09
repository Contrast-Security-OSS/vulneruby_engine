# frozen_string_literal: true

RSpec.describe('Misconfiguration Controller', type: :request) do
  describe 'GET /misconfiguration' do
    it 'renders the misconfiguration page' do
      get '/vulneruby_engine/misconfiguration'
      expect(response).to(render_template(:index))
    end
  end

  describe 'POST /misconfiguration' do
    subject(:post_request) { post '/vulneruby_engine/misconfiguration' }

    before { post_request }

    it 'renders the misconfiguration result page' do
      expect(response).to(render_template(:run))
    end

    %w[
      Cache-Control
      Pragma
      Expires
      X-XSS-Protection
      X-Frame-Options
      X-Content-Type-Options
      X-Content-Security-Policy
    ].each do |header|
      it { expect(response.body).to(include(header)) }
    end
  end
end
