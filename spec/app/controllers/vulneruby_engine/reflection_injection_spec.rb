# frozen_string_literal: true

::RSpec.describe('Reflection Injection Controller', type: :request) do
  describe 'GET /reflection_injection' do
    it 'renders the reflection injection input page' do
      get '/vulneruby_engine/reflection_injection'
      expect(response).to(render_template(:index))
    end
  end

  describe 'POST /reflection_injection' do
    it 'renders any loads a rendered const' do
      post '/vulneruby_engine/reflection_injection', params: { const: 'Kernel' }
      expect(response).to(render_template(:run))
      expect(response.body).to(include('Kernel'))
    end
  end
end
