# frozen_string_literal: true

RSpec.describe('Autoload Controller', type: :request) do
  describe 'GET /autoload' do
    it 'renders the included input page' do
      get '/vulneruby_engine/autoload'
      expect(response).to(render_template(:index))
    end
  end

  describe 'POST /included' do
    it 'renders the autoload input page' do
      post '/vulneruby_engine/autoload'
      expect(response).to(render_template(:run))
      expect(response.body).to(include('digest', 'random'))
    end
  end
end
