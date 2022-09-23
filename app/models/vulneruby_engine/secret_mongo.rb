# frozen_string_literal: true

module VulnerubyEngine
  class SecretMongo
    include Mongoid::Document
    field :name, type: String
    field :value, type: String
    field :created_at, :type => Date
    field :updated_at, :type => Date
  end
end
  