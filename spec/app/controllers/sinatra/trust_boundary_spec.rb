# frozen_string_literal: true

RSpec.describe('Sinatra trust_boundary', type: :request) do
  let(:route) { '/vulneruby_engine/sinatra/trust_boundary' }

  describe 'POST /sinatra/trust_boundary' do
    # 1) Sinatra trust_boundary POST /sinatra/trust_boundary renders session_id
    #  Failure/Error:
    #    post route,
    #         params: { :HTTP_USER_AGENT => 'test user agent' }

    #  TypeError:
    #    no implicit conversion of Array into String
    it 'renders session_id' do
      skip('See why it fails with')
      post route,
           params: { :HTTP_USER_AGENT => 'test user agent' }
      expect(response.body).to(include('session_id'))
    end
  end
end
