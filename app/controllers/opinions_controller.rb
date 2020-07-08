class OpinionsController < ApplicationController
  before_action :set_opinion, only: %i[show edit update destroy retweet]
  before_action :authenticate_user!, except: %i[index show]

  # GET /opinions
  # GET /opinions.json
  def index
    if current_user
      @opinions = current_user.followeds_opinions
      @users = current_user.who_follow
    else
      @opinions = Opinion.order(created_at: :desc).includes(:user, :copied)
      @users = User.order(created_at: :desc)
    end
    @opinion = Opinion.new
  end

  # GET /opinions/1
  # GET /opinions/1.json
  def show; end

  # GET /opinions/new
  def new
    @opinion = Opinion.new
  end

  # GET /opinions/1/edit
  def edit
    redirect_to opinions_path unless current_user == @opinion.user
  end

  # POST /opinions
  # POST /opinions.json
  def create
    @opinion = current_user.opinions.build(opinion_params)
    @opinions = current_user.followeds_opinions
    @users = current_user.who_follow

    respond_to do |format|
      if @opinion.save
        format.html { redirect_to opinions_path, notice: 'Opinion was successfully created.' }
      else
        format.html { render :index }
      end
    end
  end

  # PATCH/PUT /opinions/1
  # PATCH/PUT /opinions/1.json
  def update
    respond_to do |format|
      if @opinion.update(opinion_params)
        format.html { redirect_to opinions_path, notice: 'Opinion was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /opinions/1
  # DELETE /opinions/1.json
  def destroy
    @opinion.destroy
    respond_to do |format|
      format.html { redirect_to request.referer, notice: 'Opinion was successfully deleted.' }
    end
  end

  def retweet
    current_user.copy_opi(@opinion)
    redirect_to opinions_path
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_opinion
    @opinion = Opinion.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = 'Nonexistent post id'
    redirect_to opinions_path
  end

  # Only allow a list of trusted parameters through.
  def opinion_params
    params.require(:opinion).permit(:text)
  end
end
