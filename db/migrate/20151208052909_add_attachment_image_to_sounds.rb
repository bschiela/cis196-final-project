class AddAttachmentImageToSounds < ActiveRecord::Migration
  def self.up
    change_table :sounds do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :sounds, :image
  end
end
