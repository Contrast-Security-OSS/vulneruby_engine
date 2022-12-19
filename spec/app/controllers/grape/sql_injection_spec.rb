RSpec.describe('SQL Injection Controller', type: :request) do
    describe 'GET /sql_injection' do
      it 'renders the sql injection input page' do
        get '/vulneruby_engine/grape/sql_injection'
        expect(response.body).to(include('SQL Injection'.downcase))
      end
    end
  
    describe 'POST /sql_injection' do
      it 'renders any loads a rendered const' do
        post '/vulneruby_engine/grape/sql_injection', params: { id: '1 OR 1 = 1' }
        expect(JSON.parse(response.body).symbolize_keys).to(include( result: '1 OR 1 = 1'))
      end
    end
  end
  