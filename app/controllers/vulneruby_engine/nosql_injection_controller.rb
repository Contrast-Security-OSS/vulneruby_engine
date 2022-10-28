# frozen_string_literal: true

module VulnerubyEngine
    # Entry point for the NoSql Injection tests
    class NosqlInjectionController < ApplicationController
      def index
        render('layouts/vulneruby_engine/nosql_injection/index')
      end
  
      def run
        @result = SecretMongo.where(name: params[:name]).to_a
        begin
          puts "NOSQLI PARAM: #{ params[:name]}"
          logger = Logger.new(STDOUT)
          logger.level = Logger::INFO
          client = Mongoid::Clients.default
          client["dummy_collections", :capped => true, :size => 1024].create
          db = client.database
          collections = db.collection_names
          logger.info("MongoDB #{db.name} has collections #{collections}")
          collection = db[collections[0].to_sym]
          doc = {"name": SecureRandom.base64(5), "date": DateTime.now, "text": SecureRandom.base64(3) }
          collection.insert_one(doc)
          result = collection.find(name: params[:name]).first
          render('layouts/vulneruby_engine/nosql_injection/run')
        rescue Mongo::Error => e
          logger.error("[MongoError]", error: e)
          logger.error(e.backtrace)
          raise(e)
        end
      end
    end
  end
  