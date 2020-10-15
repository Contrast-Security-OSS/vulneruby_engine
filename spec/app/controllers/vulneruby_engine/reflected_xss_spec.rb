# frozen_string_literal: true

::RSpec.describe('Reflected XSS Controller', type: :request) do
  describe 'GET /reflected_xss' do
    it 'renders the reflected xss input page' do
      get '/vulneruby_engine/reflected_xss'
      expect(response).to(render_template(:index))
    end
  end

  describe 'POST /reflected_xss' do
    it 'renders any requested file contents' do
      post '/vulneruby_engine/reflected_xss',
           params: { data: '<script>alert(1);</script>' }
      expect(response).to(render_template(:run))
      expect(response.body).to(include('<script>alert(1);</script>'))
    end
  end
end
