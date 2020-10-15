# frozen_string_literal: true

::RSpec.describe('Reflected XSS Controller', type: :request) do
  let(:route) { '/vulneruby_engine/sinatra/reflected_xss' }

  describe 'GET /sinatra/reflected_xss' do
    it 'renders the reflected xss input page' do
      get route
      expect(response.body).to(include('Reflected XSS'))
    end
  end

  describe 'POST /sinatra/reflected_xss' do
    it 'renders any requested file contents' do
      post route,
           params: { data: '<script>alert(1);</script>' }
      expect(response.body).to(include('<script>alert(1);</script>'))
    end
  end
end
