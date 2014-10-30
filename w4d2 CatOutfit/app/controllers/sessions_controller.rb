class SessionsController < ApplicationController
  before_action :redirect_to_cats_if_signed_in, only: [:new, :create]
  
  def new
    @user = User.new
    render :new
  end
  
  def create
    @user = User.find_by_credentials(
      params[:user][:user_name],
      params[:user][:password]
    )
    
    if @user.nil?
      @user = User.new(params.require(:user).permit(:user_name))
      flash.now[:errors] = ["Incorrect username or password"]
      render :new
    else
      login_user!
    end
  end
  
  def destroy
    current_user.reset_session_token!
    session[:session_token] = nil
    redirect_to new_session_url
  end
end
