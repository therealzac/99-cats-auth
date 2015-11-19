class UsersController < ApplicationController
  before_action :redirect_if_user, only: [:new, :create]

  def create
    @user = User.new(user_params)
    session[:session_token] = @user.generate_session_token

    if @user.save
      redirect_to user_url(@user)
    else
      render :new
    end
  end

  def new
    @user = User.new
    render :new
  end

  def show
    @user = current_user
    render :show
  end

  private

  def user_params
    params.require(:user).permit(:user_name, :password)
  end

end
