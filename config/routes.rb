VulnerubyEngine::Engine.routes.draw do
  root 'application#home'

  get '/cmdi' => 'cmdi#index'
  post '/cmdi' => 'cmdi#run'
end
