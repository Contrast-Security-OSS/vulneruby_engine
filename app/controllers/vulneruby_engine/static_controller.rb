require_dependency "vulneruby_engine/application_controller"

module VulnerubyEngine
  class StaticController < ApplicationController
    def index
      puts 'hit index'
    end
  end
end
