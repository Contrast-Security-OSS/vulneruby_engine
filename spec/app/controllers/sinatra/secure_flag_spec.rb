# frozen_string_literal: true

RSpec.describe('Sinatra secure flag missing', type: :request) do
  let(:route) { '/vulneruby_engine/sinatra/secure_flag' }

  describe 'GET /sinatra/secure_flag' do
    it 'renders response' do
      get route
      expect(response.body).to(include('secure-flag'))
    end
  end
end
