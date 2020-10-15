# frozen_string_literal: true

::RSpec.describe('SSRF Controller', type: :request) do
  describe 'GET /ssrf' do
    it 'renders the ssrf input page' do
      get '/vulneruby_engine/ssrf'
      expect(response).to(render_template(:index))
    end
  end

  describe 'POST /ssrf' do
    it 'renders the ssrf input page' do
      input = 'http://localhost:3000'
      post '/vulneruby_engine/ssrf',
           params: { uri: input }
      expect(response).to(render_template(:run))
      expect(response.body).to(include(input))
    end
  end
end
