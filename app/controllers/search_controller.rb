class SearchController < ApplicationController
  def search
    @key = params[:key].squish
    logger.debug "SEARCH KEY = #{@key}"
    keys = @key.split(' ')
    if @key.size == 0 then redirect_to '/' and return end
    
    sound_where_clause = "WHERE"
    user_where_clause = "WHERE"
    playlist_where_clause = "WHERE"
    keys.each do |k|
      sound_where_clause << " name LIKE '%#{k}%' OR genre LIKE '%#{k}%'"
      user_where_clause << " name LIKE '%#{k}%' OR genres LIKE '%#{k}%'"
      playlist_where_clause << " name LIKE '%#{k}%'"
      unless k.equal? keys.last
        sound_where_clause << " OR"
        user_where_clause << " OR"
        playlist_where_clause << " OR"
      end
    end

    @sounds = Sound.find_by_sql("SELECT * FROM sounds " + sound_where_clause)
    @users = User.find_by_sql("SELECT * FROM users " + user_where_clause)
    @playlists = Playlist.find_by_sql("SELECT * FROM playlists " + playlist_where_clause)
    
    render :index
  end
end
