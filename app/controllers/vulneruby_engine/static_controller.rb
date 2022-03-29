require_dependency "vulneruby_engine/application_controller"

module VulnerubyEngine
  class StaticController < ApplicationController
    def index
      render('layouts/vulneruby_engine/static_path/index')
    end
  end
end
