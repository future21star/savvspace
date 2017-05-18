class AmbassadorshipsController < ApplicationController
  before_action :set_ambassadorship, only: %i[show edit update destroy]
  before_action :new_ambassadorship, only: :create
  before_action :require_admin

  # GET /ambassadorships
  # GET /ambassadorships.json
  def index
    @ambassadorships = Ambassadorship.all
  end

  # GET /ambassadorships/1
  # GET /ambassadorships/1.json
  def show; end

  # GET /ambassadorships/new
  def new
    @ambassadorship = Ambassadorship.new
  end

  # GET /ambassadorships/1/edit
  def edit; end

  # POST /ambassadorships
  # POST /ambassadorships.json
  def create
    respond_to do |format|
      if @ambassadorship.save
        format.html { redirect_to @ambassadorship, notice: t('.notice') }
        format.json { render :show, status: :created, location: @ambassadorship }
      else
        format.html { render :new }
        format.json { render json: @ambassadorship.errors, status: :unprocessable_entity }
      end
      format.js { render :create }
    end
  end

  # PATCH/PUT /ambassadorships/1
  # PATCH/PUT /ambassadorships/1.json
  def update
    respond_to do |format|
      if @ambassadorship.update(ambassadorship_params)
        format.html { redirect_to @ambassadorship, notice: t('.notice') }
        format.json { render :show, status: :ok, location: @ambassadorship }
      else
        format.html { render :edit }
        format.json { render json: @ambassadorship.errors, status: :unprocessable_entity }
      end
      format.js { render :update }
    end
  end

  # DELETE /ambassadorships/1
  # DELETE /ambassadorships/1.json
  def destroy
    @ambassadorship.destroy
    @ambassadorship = Ambassadorship.new(area: @ambassadorship.area)
    respond_to do |format|
      format.html { redirect_to ambassadorships_url, notice: t('.notice') }
      format.json { head :no_content }
      format.js { render :destroy }
    end
  end

  private

  # Only allow for create action
  def new_ambassadorship
    @ambassadorship = Ambassadorship.new(ambassadorship_params)
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_ambassadorship
    @ambassadorship = Ambassadorship.find(params[:id])
  end

  # Never trust parameters from the scary internet,
  # only allow the white list through.
  def ambassadorship_params
    params.require(:ambassadorship).permit(:user_id, :area_id)
  end
end
