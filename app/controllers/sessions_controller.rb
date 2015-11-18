class SessionsController < ApplicationController
  def new
    render :new
  end

  def create
    @user = User.find_by_credentials(
      params[:user][:user_name],
      params[:user][:password]
    )

    if @user.nil?
      render :new
    else
      login!(@user)
      redirect_to user_url(@user)
    end
  end

  def destroy
    current_user.reset_session_token! if current_user

    logout!

    render :new
  end
end
