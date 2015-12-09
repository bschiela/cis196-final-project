class PlaylistsSound < ActiveRecord::Base
  belongs_to :playlist
  belongs_to :sound
end
