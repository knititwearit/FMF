class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    sign_in user
    redirect_to user 
    flash[:success] = "Welcome to Five Minute Friend"
  end
  

  def destroy
    sign_out
    #redirect_to root_url , notice: "Signed out!"
    redirect_to root_url
    flash[:success] = "Signed out!"
  end

  def failure
    redirect_to root_url, alert: "Authentication failed, please try again."
  end
  
end
