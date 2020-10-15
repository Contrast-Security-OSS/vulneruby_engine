# frozen_string_literal: true

::RSpec.describe('XXE Controller', type: :request) do
  describe 'GET /xxe' do
    it 'renders the xxe input page' do
      get '/vulneruby_engine/xxe'
      expect(response).to(render_template(:index))
    end
  end

  describe 'POST /xxe' do
    it 'renders the xxe result page' do
      post '/vulneruby_engine/xxe', params: { entity: 'nokogiri' }
      expect(response).to(render_template(:run))
      expect(response.body).to(include('nokogiri'))
    end
  end
end
