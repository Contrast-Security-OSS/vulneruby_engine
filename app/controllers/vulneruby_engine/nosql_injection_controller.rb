# frozen_string_literal: true

module VulnerubyEngine
    # Entry point for the NoSql Injection tests
    class NosqlInjectionController < ApplicationController
      def index
        render('layouts/vulneruby_engine/nosql_injection/index')
      end
  
      def run
        @result = SecretMongo.where(:'id'.ne => params[:id]).to_a
        render('layouts/vulneruby_engine/nosql_injection/run')
      end
    end
  end
  