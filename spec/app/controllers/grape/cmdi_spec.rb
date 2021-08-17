# frozen_string_literal: true

RSpec.describe('Grape cmdi', type: :request) do
  let(:route) { '/vulneruby_engine/grape/cmdi?cmd=ls' }

  describe 'GET /grape/cdmi' do
    it 'gets the response body' do
      post route
      expect(response.body).to(include('Rakefile'))
    end
  end
end
