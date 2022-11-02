# frozen_string_literal: true

module VulnerubyEngine
    # Entry point for the NoSql Injection tests
    class NosqlInjectionController < ApplicationController
      def index
        render('layouts/vulneruby_engine/nosql_injection/index')
      end
  
      def run
        begin
          collection_name = "dummy_collections"
          puts "NOSQLI PARAM: #{ params[:name]}"

          client = Mongoid::Clients.default
          db = client.database
          collections = db.collection_names

          client[collection_name, :capped => true, :size => 1024].create unless collections.include?(collection_name)
          collection = db[collections[0].to_sym]
          doc = { name: SecureRandom.base64(5), date: DateTime.now, text: SecureRandom.base64(3) }
          collection.insert_one(doc)
          @result = collection.find(name: params[:name]).first
          render('layouts/vulneruby_engine/nosql_injection/run')
        rescue Mongo::Error => e
          puts "[MongoError]. #{e}"
        end
      end
    end
  end
  