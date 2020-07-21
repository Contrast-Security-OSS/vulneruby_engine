# frozen_string_literal: true

RSpec.describe('SQL Injection Controller', type: :request) do
  describe 'GET /sql_injection' do
    it 'renders the sql injection input page' do
      get '/vulneruby_engine/sql_injection'
      expect(response).to(render_template(:index))
    end
  end

  describe 'POST /sql_injection' do
    it 'renders any loads a rendered const' do
      post '/vulneruby_engine/sql_injection', params: { id: "1 OR 1 = 1" }
      expect(response).to(render_template(:run))
    end
  end
end
