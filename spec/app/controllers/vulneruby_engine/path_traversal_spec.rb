# frozen_string_literal: true

RSpec.describe('Path Traversal Controller', type: :request) do
  describe 'GET /path_traversal' do
    it 'renders the path traversal input page' do
      get '/vulneruby_engine/path_traversal'
      expect(response).to(render_template(:index))
    end
  end

  describe 'POST /cmdi' do
    it 'renders any requested file contents' do
      post '/vulneruby_engine/path_traversal',
           params: { file_path: '/etc/passwd' }
      expect(response).to(render_template(:run))
      expect(response.body).to(include('root'))
    end
  end
end
