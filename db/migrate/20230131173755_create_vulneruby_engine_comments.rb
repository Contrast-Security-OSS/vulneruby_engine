class CreateVulnerubyEngineComments < ActiveRecord::Migration[7.0]
  def change
    create_table :vulneruby_engine_comments do |t|
      t.belongs_to :user, foreign_key: true
      t.text :message

      t.timestamps
    end
  end
end
