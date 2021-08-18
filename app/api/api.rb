# frozen_string_literal: true

require 'grape'

class Api < Grape::API
  mount VulnerubyEngine::GrapeController
end
