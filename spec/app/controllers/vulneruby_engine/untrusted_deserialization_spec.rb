# frozen_string_literal: true

RSpec.describe('Untrusted Deserialization Controller', type: :request) do
  describe 'GET /untrusted_deserialization' do
    it 'renders the untrusted_deserialization input page' do
      get '/vulneruby_engine/untrusted_deserialization'
      expect(response).to(render_template(:index))
    end
  end

  describe 'POST /untrusted_deserialization' do
    it 'renders the untrusted deserialization result page' do
      post '/vulneruby_engine/untrusted_deserialization',
           params: { data: Marshal.dump('this_is_the_data') }
      expect(response).to(render_template(:run))
      expect(response.body).to(include('this_is_the_data'))
    end
  end
end
