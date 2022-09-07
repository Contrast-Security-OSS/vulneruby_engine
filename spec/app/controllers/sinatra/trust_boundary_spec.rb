# frozen_string_literal: true

RSpec.describe('Sinatra trust_boundary', type: :request) do
  let(:route) { '/vulneruby_engine/sinatra/trust_boundary' }

  describe 'POST /sinatra/trust_boundary' do
    it 'renders session_id' do
      post route,
           params: { :HTTP_USER_AGENT => 'test user agent' }
      expect(response.body).to(include('session_id'))
    end
  end
end
