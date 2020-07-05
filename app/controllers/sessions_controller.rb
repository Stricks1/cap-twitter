class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by_username(params[:username])
    if user
      session[:user_id] = user.id
      session[:username] = user.username
      redirect_to root_url, notice: 'Logged in!'
    else
      flash.now[:alert] = 'Username invalid'
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    session[:username] = nil
    redirect_to root_url, notice: 'Logged out!'
  end
end
