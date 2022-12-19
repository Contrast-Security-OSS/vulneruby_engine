# frozen_string_literal: true

VulnerubyEngine::Engine.routes.draw do
  get 'static/index'
  root 'application#home'

  RULES = %w[
    autoload
    cmdi_sidekiq
    cmdi
    included
    insecure_algorithm
    path_traversal
    reflection_injection
    reflected_xss
    regex_dos
    sql_injection
    nosql_injection
    ssrf
    unsafe_code_execution
    unsafe_file_upload
    untrusted_deserialization
    misconfiguration
    xpath_injection
    xxe
  ].freeze

  RULES.each do |rule|
    get  "/#{ rule }" => "#{ rule }#index"
    post "/#{ rule }" => "#{ rule }#run"
  end
  
  # Exclusions
  get "sql_injection_exclusion" => "sql_injection#index"
  post "sql_injection_exclusion" => "sql_injection#run"

  get  '/sinatra' => VulnerubyEngine::SinatraController, :anchor => false # rubocop:disable Style/StringHashKeys
  post '/sinatra' => VulnerubyEngine::SinatraController, :anchor => false # rubocop:disable Style/StringHashKeys
  get  '/grape' => VulnerubyEngine::GrapeController, :anchor => false # rubocop:disable Style/StringHashKeys
  post '/grape' => VulnerubyEngine::GrapeController, :anchor => false # rubocop:disable Style/StringHashKeys
end
