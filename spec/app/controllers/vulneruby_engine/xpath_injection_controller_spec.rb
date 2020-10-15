# frozen_string_literal: true

::RSpec.describe('XPath Injection Controller', type: :request) do
  describe 'GET /xpath_injection' do
    it 'renders the xpath_injection input page' do
      get '/vulneruby_engine/xpath_injection'
      expect(response).to(render_template(:index))
    end
  end

  describe 'POST /xpath_injection' do
    it 'renders the xpath injection result page' do
      post '/vulneruby_engine/xpath_injection', params: { xpath_data: 'add some arbitrary data' }
      expect(response).to(render_template(:run))
      expect(response.body).to(include('add some arbitrary data'))
    end
  end
end
