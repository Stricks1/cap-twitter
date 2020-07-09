class SessionsController < ApplicationController
  before_action :set_user, only: %i[create]

  def new; end

  def create
    if @user
      session[:user_id] = @user.id
      session[:username] = @user.username
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

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find_by_username(params[:username])
  rescue ActiveRecord::RecordNotFound
    @user = nil
  end
end
