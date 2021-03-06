class PlaylistsController < ApplicationController
  before_action :set_playlist, only: [:show, :edit, :update, :destroy]
  skip_before_filter :verify_authenticity_token, :only => :create

  # GET /users/:user_id/playlists
  def index
    @user = User.find(params[:user_id])
    render 'users/show.html', locals: { content: 'user_playlists' }
  end

  # GET /users/:user_id/playlists/:id
  def show
    render :show
  end

  # GET /users/:user_id/playlists/new
  def new
    @playlist = Playlist.new
    render :new
  end

  # GET /users/:user_id/playlists/:id/edit
  def edit
    render :edit unless !has_privilege?
  end

  # POST /users/:user_id/playlists
  def create
    @playlist = Playlist.new(playlist_params)
    @playlist.user = current_user

    logger.debug "SAVING NEW PLAYLIST: #{@playlist.attributes.inspect}"
    if @playlist.save
      redirect_to user_playlists_path(current_user.id), notice: 'Playlist was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /users/:user_id/playlists/:id
  def update
    has_privilege?
    if @playlist.update(playlist_params)
      redirect_to user_playlist_path(current_user, @playlist), notice: 'Playlist was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /users/:user_id/playlists/:id
  def destroy
    has_privilege?
    @playlist.destroy
    redirect_to user_playlists_path(current_user), notice: 'Playlist was successfully destroyed.'
  end

  # GET /playlist (not post because authenticity token issue)
  def addSound
    playlist = Playlist.find(params[:playlist_id])
    @sound = Sound.find(params[:sound_id])
    if playlist.sounds.include? @sound
      redirect_to user_sound_path(@sound.user.id, @sound.id), alert: "This sound is already in #{playlist.name}"
    else
      playlist.sounds.push(@sound)
      redirect_to user_sound_path(@sound.user.id, @sound.id), notice: "Sound successfully added to #{playlist.name}."
    end
  end

  # DELETE /playlist/:playlist_id/sound/:sound_id
  def removeSound
    playlist = Playlist.find(params[:playlist_id])
    sound = Sound.find(params[:sound_id])
    if playlist.sounds.delete(sound)
      redirect_to user_playlist_path(current_user.id, params[:playlist_id]), notice: 'Successfully removed sound from playlist.'
    else
      redirect_to user_playlist_path(current_user.id, params[:playlist_id]), alert: 'An error occurred'
    end
  end

  private

    # check user editing privileges
    def has_privilege?
      if (!logged_in?)
        redirect_to '/login' and return
      elsif (params[:user_id].to_i != current_user.id)
        redirect_to user_playlists_path(current_user) and return
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_playlist
      @playlist = Playlist.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def playlist_params
      params.require(:playlist).permit(:name, :description, :image)
    end
end
