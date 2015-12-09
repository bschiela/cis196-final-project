class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.string :description
      t.string :location
      t.datetime :start_datetime
      t.datetime :end_datetime
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
