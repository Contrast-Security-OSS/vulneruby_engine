# frozen_string_literal: true

RSpec.describe('Sinatra httponly flag missing', type: :request) do
  let(:route) { '/vulneruby_engine/sinatra/httponly_flag' }

  describe 'GET /sinatra/httponly_flag' do
    it 'renders response' do
      get route
      expect(response.body).to(include('httponly-flag'))
    end
  end
end
