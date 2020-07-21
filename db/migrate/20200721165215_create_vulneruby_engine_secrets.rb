class CreateVulnerubyEngineSecrets < ActiveRecord::Migration[6.0]
  def change
    create_table :vulneruby_engine_secrets do |t|
      t.string :name
      t.string :value

      t.timestamps
    end
  end
end
