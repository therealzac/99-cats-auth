class ApplicationController < ActionController::Base

  helper_method :current_user
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def login!(user)
    @user = user
    session[:session_token] = user.session_token
  end

  def current_user
    return nil if self.session[:session_token].nil?
    User.find_by(session_token: self.session[:session_token])
  end

  def redirect_if_unauthenticated
  end

  def logout!
    current_user.reset_session_token!
    self.session[:session_token] = nil
  end

  private
  def redirect_if_user
    redirect_to cats_url if current_user
  end
end
