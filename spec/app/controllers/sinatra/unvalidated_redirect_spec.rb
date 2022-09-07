# frozen_string_literal: true

RSpec.describe('Sinatra unvalidated_redirect', type: :request) do
  let(:route) { '/vulneruby_engine/sinatra/unvalidated_redirect' }

  describe 'GET /sinatra/unvalidated_redirect' do
    it 'redirects' do
      post route, params: { url: 'https://www.example.com' }
      expect(response.status).to(eq(302))
    end
  end
end
