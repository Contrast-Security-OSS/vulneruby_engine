# frozen_string_literal: true

RSpec.describe('Grape secure flag missing', type: :request) do
  let(:route) { '/vulneruby_engine/grape/secure_flag' }

  describe 'GET /grape/secure_flag' do
    it 'renders response' do
      get route
      expect(response.body).to(include('secure-flag'))
    end
  end
end
