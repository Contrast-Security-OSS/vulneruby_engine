# frozen_string_literal: true

RSpec.describe('Grape trust_boundary', type: :request) do
  let(:route) { '/vulneruby_engine/grape/trust_boundary' }

  describe 'GET /grape/trust_boundary' do
    it 'renders session_id' do
      get(route, params: { 'HTTP_USER_AGENT' => 'test user agent' })
      expect(response.body).to(include('session_id'))
    end
  end
end
