# frozen_string_literal: true

RSpec.describe('Included Controller', type: :request) do
  describe 'GET /included' do
    it 'renders the included input page' do
      get '/vulneruby_engine/included'
      expect(response).to(render_template(:index))
    end
  end

  describe 'POST /included' do
    it 'renders the included input page' do
      post '/vulneruby_engine/included'
      expect(response).to(render_template(:run))
      expect(response.body).to(include('digest', 'random'))
    end
  end
end
