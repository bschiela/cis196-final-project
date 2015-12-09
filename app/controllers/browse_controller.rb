class BrowseController < ApplicationController

  # GET /sounds
  def sounds
    @sounds = Sound.all
    render :'sounds/index'
  end

  # GET /playlists
  def playlists
    @playlists = Playlist.all
    render :'playlists/index'
  end

  # GET /news
  def stories
    # TODO
  end

  # GET /calendar
  def events
    # TODO
  end
end
