# frozen_string_literal: true

RSpec.describe('Cmdi Controller', type: :request) do
  describe 'GET /cmdi' do
    it 'renders the cmdi input page' do
      get '/vulneruby_engine/cmdi'
      expect(response).to(render_template(:index))
    end
  end

  describe 'POST /cmdi' do
    it 'renders the cmdi input page' do
      post '/vulneruby_engine/cmdi', params: { command: 'echo "Hi There"' }
      expect(response).to(render_template(:run))
      expect(response.body).to(include('Hi There'))
    end
  end
end
