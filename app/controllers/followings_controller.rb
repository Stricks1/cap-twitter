class FollowingsController < ApplicationController
  before_action :authenticate_user!

  # POST /followings/user
  # POST /followings/user.json
  def create
    @following = Following.new
    @user = User.find(params[:id])
    if  @following.build_saving(@user, current_user)
      flash[:notice] = "Success following #{@user.username}"
    else
      flash[:alert] = "Error to follow #{@user.username}"
    end
    redirect_to request.referer
  end

  # DELETE /followings/1
  # DELETE /followings/1.json
  def destroy
    @user = User.find(params[:id])
    current_user.unfollow(@user)
    flash[:notice] = "Unfollow #{@user.username}"
    redirect_to request.referer
  end

  private
    # Only allow a list of trusted parameters through.
    def following_params
      params.fetch(:following, {})
    end
end
