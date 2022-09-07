# frozen_string_literal: true

RSpec.describe('Sinatra unset rack session', type: :request) do
  let(:route) { '/vulneruby_engine/sinatra/unset_rack_session' }

  describe 'GET /sinatra/unset_rack_session' do
    it 'renders response' do
      get route
      expect(response.body).to(include('Expire time is unset'))
    end
  end
end
