class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
    render :index
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
    render :'users/show.html'
  end

  # GET /users/new
  def new
    @user = User.new
    render :new
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
    render :'users/edit.html'
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    logger.debug "saving new User: #{@user.attributes.inspect}"
    if password_confirmed? && @user.save
      session[:user_id] = @user.id
      redirect_to @user, notice: 'User was successfully created.'
    else
      if (!password_confirmed)
        @user.errors.add(:password_confirmation, 'fields do not match')
      end
      render :new
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    if password_confirmed? && @user.update(user_params)
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    reset_session
    redirect_to '/', notice: 'User was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:username, :name, :password, :email, :bio, :genres, :image)
  end

  # password must be confirmed in form
  def password_confirmed?
    params[:user][:password] == params[:user][:password_confirmation]
  end
end
