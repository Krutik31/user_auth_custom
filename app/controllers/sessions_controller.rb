class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: %i[new create]
  before_action :redirect_if_authenticated, only: %i[new create]

  def new
    @user = User.new
  end

  def create
    reset_session
    @user = User.find_by_username(params[:user][:username])
    if @user.present? && @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id
      redirect_to root_path, flash: { success: 'Logged in successfully' }
    else
      redirect_to new_session_path, flash: { danger: 'Username & Password has not matched.' }
    end
  end

  def destroy
    reset_session
    redirect_to root_path, flash: { danger: 'Logged Out' }
  end
end
