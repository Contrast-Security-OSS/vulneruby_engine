# frozen_string_literal: true

RSpec.describe('Sinatra ssrf', type: :request) do
  let(:route) { '/vulneruby_engine/sinatra/ssrf?uri=http://www.example.com' }

  describe 'POST /sinatra/ssrf' do
    it 'get the uri' do
      post(route)
      expect(response.body).to(include('<h1>Example Domain</h1>'))
    end
  end
end
