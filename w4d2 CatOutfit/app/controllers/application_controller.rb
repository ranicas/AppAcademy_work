class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user
  
  def current_user
    return nil if self.session[:session_token].nil?
    @user ||= User.find_by(session_token: session[:session_token])
  end
  
  def login_user!
    session[:session_token] = @user.reset_session_token!
    redirect_to cats_url
  end
  
  def redirect_to_cats_if_signed_in
    unless current_user.nil?
      redirect_to cats_url
    end
  end
end
