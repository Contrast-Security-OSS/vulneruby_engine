# frozen_string_literal: true

::RSpec.describe('Regex DoS Controller', type: :request) do
  describe 'GET /regex_dos' do
    it 'renders the regex dos input page' do
      get '/vulneruby_engine/regex_dos'
      expect(response).to(render_template(:index))
    end
  end

  describe 'POST /regex_dos' do
    it 'renders any loads a rendered const' do
      post '/vulneruby_engine/regex_dos', params: { data: 'some arbitrary regex method' }
      expect(response).to(render_template(:run))
    end
  end
end
