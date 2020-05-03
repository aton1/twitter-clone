class TweeetsController < ApplicationController
  before_action :set_tweeet, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  # GET /tweeets
  # GET /tweeets.json
  def index
    @tweeets = Tweeet.all.order("created_at DESC")
    @tweeet = Tweeet.new
    user_signed_in? ? @users = User.order("RANDOM()").limit(4).where.not(id: current_user.id) : @users = User.order("RANDOM()").limit(4)
  end

  # GET /tweeets
  # GET /tweeets/1.json
  def show
    @users = User.all.where.not(id: current_user.id).shuffle
  end

  # GET /tweeets/new
  def new
    @tweeet = current_user.tweeets.build
  end

  # GET /tweeets/1/edit
  def edit
    @users = User.all.where.not(id: current_user.id).shuffle
  end

  # POST /tweeets
  # POST /tweeets.json
  def create
    @tweeet ||= current_user.tweeets.build(tweeet_params)

    respond_to do |format|
      if @tweeet.save
        format.html { redirect_to root_path, notice: 'Tweet was successfully created.' }
        format.json { render :show, status: :created, location: @tweeet }
      else
        format.html { redirect_to @tweeet, alert: @tweeet.errors.full_messages.to_sentence }
        format.json { render :index, status: :unprocessable_entity, location: @tweeet }
      end
    end
  end

  # PATCH/PUT /tweeets/1
  # PATCH/PUT /tweeets/1.json
  def update
    respond_to do |format|
      if @tweeet.update(tweeet_params)
        format.html { redirect_to @tweeet, notice: 'Tweet was successfully updated.' }
        format.json { render :show, status: :ok, location: @tweeet }
      else
        format.html { render :edit }
        format.json { render json: @tweeet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tweeets/1
  # DELETE /tweeets/1.json
  def destroy
    @tweeet.destroy
    respond_to do |format|
      format.html { redirect_to tweeets_url, notice: 'Tweet was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tweeet
      @tweeet = Tweeet.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def tweeet_params
      params.require(:tweeet).permit(:tweeet)
    end
end
