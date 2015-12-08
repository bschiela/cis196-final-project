class SoundsController < ApplicationController
  before_action :set_sound, only: [:show, :edit, :update, :destroy]

  # GET /users/:user_id/sounds
  def index
    @user = User.find(params[:user_id])
    render 'users/show.html', locals: { content: 'user_sounds' }
  end

  # GET /users/:user_id/sounds/:id
  def show
    render :show
  end

  # GET /users/:user_id/sounds/new
  def new
    @sound = Sound.new
    render :new
  end

  # GET /users/:user_id/sounds/:id/edit
  def edit
    render :edit unless !has_privilege?
  end

  # POST /users/:user_id/sounds
  def create
    @sound = Sound.new(sound_params)
    @sound.user = current_user

    logger.debug "SAVING NEW SOUND: #{@sound.attributes.inspect}"
    if @sound.save
      redirect_to user_sounds_path(current_user.id), notice: 'Sound was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /users/:user_id/sounds/:id
  def update
    has_privilege?
    if @sound.update(sound_params)
      redirect_to user_sound_path(current_user, @sound), notice: 'Sound was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /users/:user_id/sounds/:id
  def destroy
    has_privilege?
    @sound.destroy
    redirect_to user_sounds_path(current_user), notice: 'Sound was successfully destroyed.'
  end

  private

    # check user editing privileges
    def has_privilege?
      if (!logged_in?)
        redirect_to '/login'
      elsif (params[:user_id] != current_user.id)
        redirect_to user_sounds_path(current_user)
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_sound
      @sound = Sound.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sound_params
      params.require(:sound).permit(:name, :audio, :image, :genre, :description)
    end
end
