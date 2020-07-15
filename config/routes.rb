# frozen_string_literal: true

VulnerubyEngine::Engine.routes.draw do
  root 'application#home'

  RULES = %w[
    cmdi
    path_traversal
    reflection_injection
    ssrf
    unsafe_code_execution
    untrusted_deserialization
    misconfiguration
    xxe
  ].freeze

  RULES.each do |rule|
    get  "/#{ rule }" => "#{ rule }#index"
    post "/#{ rule }" => "#{ rule }#run"
  end
end
