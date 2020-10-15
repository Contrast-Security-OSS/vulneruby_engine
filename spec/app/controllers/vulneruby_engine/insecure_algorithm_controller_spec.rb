# frozen_string_literal: true

::RSpec.describe('Insecure Algorithm Controller', type: :request) do
  describe 'GET /insecure_algorithm' do
    it 'renders the insecure_algorithm input page' do
      get '/vulneruby_engine/insecure_algorithm'
      expect(response).to(render_template(:index))
    end
  end

  describe 'POST /insecure_algorithm' do
    it 'renders the insecure_algorithm input page' do
      post '/vulneruby_engine/insecure_algorithm'
      expect(response).to(render_template(:run))
      expect(response.body).to(include('digest', 'random'))
    end
  end
end
