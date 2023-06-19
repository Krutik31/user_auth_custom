class RegistrationsController < ApplicationController
  skip_before_action :authenticate_user, only: %i[new create]
  before_action :redirect_if_authenticated, only: %i[new create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      reset_session
      session[:user_id] = @user.id
      redirect_to root_path, flash: { success: 'Registration successfully' }
    else
      render :new, status: :unprocessable_entity
    end
  end

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end
