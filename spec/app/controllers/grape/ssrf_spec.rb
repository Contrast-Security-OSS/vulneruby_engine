# frozen_string_literal: true

RSpec.describe('Grape ssrf', type: :request) do
  let(:route) { '/vulneruby_engine/grape/ssrf?uri=http://www.example.com' }

  describe 'POST /grape/ssrf' do
    it 'get the uri' do
      post(route)
      expect(JSON.parse(response.body)).to(include('<h1>Example Domain</h1>'))
    end
  end
end
