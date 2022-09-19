# frozen_string_literal: true

# Generates a few 'secrets' meant to represent API keys or something similar
require 'vulneruby_engine/secret_mongo'

return if VulnerubyEngine::SecretMongo.all.length.positive?

%w[AWS GCP SUPER].each do |name|
    $stdout.puts("gets here")
    VulnerubyEngine::SecretMongo.create(name: "#{ name }_SECRET_API_KEY", value: SecureRandom.uuid.to_s)
end