class CreatePlaylistsSounds < ActiveRecord::Migration
  def change
    create_table :playlists_sounds do |t|
      t.references :playlist, index: true, foreign_key: true
      t.references :sound, index: true, foreign_key: true
    end
  end
end
