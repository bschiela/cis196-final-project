class SessionController < ApplicationController
  def new
    render :new
  end

  def create
    @user = User.find_by_username(params[:username])
    if !@user.nil? && (@user.password == params[:password])
      session[:user_id] = @user.id
      redirect_to @user
    else
      redirect_to '/login', notice: 'The credentials you entered did not match'
    end
  end

  def destroy
    reset_session
    redirect_to '/'
  end
end
