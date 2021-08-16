# frozen_string_literal: true

RSpec.describe('Grape unvalidated_redirect', type: :request) do
  let(:route) { '/vulneruby_engine/grape/unvalidated_redirect' }

  describe 'GET /grape/unvalidated_redirect' do
    it 'redirects' do
      post route, params: { url: 'https://www.example.com' }
      expect(response.status).to(eq(302))
    end
  end
end
