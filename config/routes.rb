# frozen_string_literal: true

VulnerubyEngine::Engine.routes.draw do
  root 'application#home'

  RULES = %w[
    cmdi
    insecure_algorithm
    path_traversal
    reflection_injection
    regex_dos
    ssrf
    unsafe_code_execution
    untrusted_deserialization
    misconfiguration
    xpath_injection
    xxe
  ].freeze

  RULES.each do |rule|
    get  "/#{ rule }" => "#{ rule }#index"
    post "/#{ rule }" => "#{ rule }#run"
  end
end
