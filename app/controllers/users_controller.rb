class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]
  before_action :authenticate_user!, only: %i[show edit update]

  # GET /users
  # GET /users.json
  def index
    redirect_to signup_url
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @opinions = Opinion.order(created_at: :desc).includes(:user, :copied).where({ user: [@user] })
    @users = @user.followds
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    redirect_to edit_user_path(current_user) unless current_user == @user
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        session[:user_id] = @user.id
        session[:username] = @user.username
        format.html { redirect_to opinions_path, notice: 'User was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to opinions_path, notice: 'User was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to logout_path, notice: 'User was successfully destroyed.' }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:username, :full_name, :photo, :cover_image)
  end
end
