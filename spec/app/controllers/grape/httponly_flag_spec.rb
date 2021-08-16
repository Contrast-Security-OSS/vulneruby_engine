# frozen_string_literal: true

RSpec.describe('Grape httponly flag missing', type: :request) do
  let(:route) { '/vulneruby_engine/grape/httponly_flag' }

  describe 'GET /grape/httponly_flag' do
    it 'renders response' do
      get route
      expect(response.body).to(include('httponly-flag'))
    end
  end
end
