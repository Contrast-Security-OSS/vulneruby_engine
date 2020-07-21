# Generates a few 'secrets' meant to represent API keys or something similar

return if VulnerubyEngine::Secret.all.count > 0

['AWS', 'GCP', 'SUPER'].each do |name|
  VulnerubyEngine::Secret.create(name: "#{name}_SECRET_API_KEY", value: SecureRandom.uuid.to_s)
end