# frozen_string_literal: true

RSpec.describe('Grape Reflected XSS', type: :request) do
  let(:route) { '/vulneruby_engine/grape/reflected_xss' }

  describe 'GET /grape/reflected_xss' do
    it 'gets the response body' do
      get route
      expect(response.body).to(include('Reflected XSS'))
    end
  end

  describe 'POST /grape/reflected_xss' do
    it 'renders POST response params' do
      post route,
           params: { data: '<script>alert(1);</script>' }
      expect(JSON.parse(response.body).symbolize_keys).to(include( result: '<script>alert(1);</script>'))
    end
  end
end
