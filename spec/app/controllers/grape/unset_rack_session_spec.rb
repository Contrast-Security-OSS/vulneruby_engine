# frozen_string_literal: true

RSpec.describe('Grape unset rack session', type: :request) do
  let(:route) { '/vulneruby_engine/grape/unset_rack_session' }

  describe 'GET /grape/unset_rack_session' do
    it 'renders response' do
      get route
      expect(response.body).to(include('Expire time is unset'))
    end
  end
end
