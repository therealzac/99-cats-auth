class UsersController < ApplicationController
  def create
    @user = User.new(user_params)
    session[:session_token] = @user.generate_session_token

    if @user.save
      redirect_to user_url
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
