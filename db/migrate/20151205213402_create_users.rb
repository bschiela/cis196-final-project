class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :name
      t.string :password_hash
      t.string :email
      t.string :bio
      t.string :genres
    end
  end
end
