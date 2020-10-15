# frozen_string_literal: true

::RSpec.describe('Unsafe Code Execution Controller', type: :request) do
  describe 'GET /unsafe_code_execution' do
    it 'renders the unsafe_code_execution input page' do
      get '/vulneruby_engine/unsafe_code_execution'
      expect(response).to(render_template(:index))
    end
  end

  describe 'POST /unsafe_code_execution' do
    it 'renders the result of the code exection' do
      post '/vulneruby_engine/unsafe_code_execution',
           params: { data: '2+2' }
      expect(response).to(render_template(:run))
      expect(response.body).to(include('4'))
    end
  end
end
