# frozen_string_literal: true
module VulnerubyEngine
  # Controller for testing included method
  class IncludedController < ApplicationController
    #Included runs InsecureAlgorithm vulnerability
    include Included
    def index
      render('layouts/vulneruby_engine/included/index')
    end
  end
end