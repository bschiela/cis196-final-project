class HomeController < ApplicationController
  def index
    @users = User.limit(8)
    @sounds = Sound.limit(8)
    @playlists = Playlist.limit(8)
    render :index
  end
end
