# frozen_string_literal: true

# Create the Secrets table
class CreateVulnerubyEngineSecrets < ::ActiveRecord::Migration[6.0] # rubocop:disable Lint/ConstantResolution
  def change
    create_table(:vulneruby_engine_secrets) do |t|
      t.string(:name)
      t.string(:value)

      t.timestamps
    end
  end
end
