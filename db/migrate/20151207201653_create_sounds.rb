class CreateSounds < ActiveRecord::Migration
  def change
    create_table :sounds do |t|
      t.string :name
      t.string :genre
      t.string :description
      t.references :user_id, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
