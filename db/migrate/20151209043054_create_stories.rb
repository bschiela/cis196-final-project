class CreateStories < ActiveRecord::Migration
  def change
    create_table :stories do |t|
      t.string :headline
      t.string :body
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
