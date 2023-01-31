class CreateVulnerubyEngineUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :vulneruby_engine_users do |t|
      t.string :name

      t.timestamps
    end
  end
end
