RSpec.describe "Application Controller", :type => :request do
  describe '/' do
    it 'renders the homepage' do
      get '/vulneruby_engine'
      expect(response).to render_template(:home)
    end
  end
end