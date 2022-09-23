# frozen_string_literal: true

RSpec.describe('Sinatra cmdi', type: :request) do
  let(:route) { '/vulneruby_engine/sinatra/cmdi?cmd=ls' }

  describe 'GET /sinatra/cdmi' do
    it 'gets the response body' do
      post route
      expect(response.body).to(include('Rakefile'))
    end
  end
end
