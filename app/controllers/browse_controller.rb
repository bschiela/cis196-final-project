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
    @stories = Story.order(created_at: :asc)
    render :'stories/index'
  end

  # GET /calendar
  def events
    @events = Event.order(start_datetime: :asc)
    render :'events/index'
  end
end
