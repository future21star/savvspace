class AmbassadorshipsController < ApplicationController
  before_action :set_ambassadorship, only: [:show, :edit, :update, :destroy]
  before_action :require_admin

  # GET /ambassadorships
  # GET /ambassadorships.json
  def index
    @ambassadorships = Ambassadorship.all
  end

  # GET /ambassadorships/1
  # GET /ambassadorships/1.json
  def show
  end

  # GET /ambassadorships/new
  def new
    @ambassadorship = Ambassadorship.new
  end

  # GET /ambassadorships/1/edit
  def edit
  end

  # POST /ambassadorships
  # POST /ambassadorships.json
  def create
    @ambassadorship = Ambassadorship.new(ambassadorship_params)

    respond_to do |format|
      if @ambassadorship.save
        format.html { redirect_to @ambassadorship, notice: 'Ambassadorship was successfully created.' }
        format.json { render :show, status: :created, location: @ambassadorship }
        format.js { render :create }
      else
        format.html { render :new }
        format.json { render json: @ambassadorship.errors, status: :unprocessable_entity }
        format.js { render :create }
      end
    end
  end

  # PATCH/PUT /ambassadorships/1
  # PATCH/PUT /ambassadorships/1.json
  def update
    respond_to do |format|
      if @ambassadorship.update(ambassadorship_params)
        format.html { redirect_to @ambassadorship, notice: 'Ambassadorship was successfully updated.' }
        format.json { render :show, status: :ok, location: @ambassadorship }
        format.js { render :update }
      else
        format.html { render :edit }
        format.json { render json: @ambassadorship.errors, status: :unprocessable_entity }
        format.js { render :update }
      end
    end
  end

  # DELETE /ambassadorships/1
  # DELETE /ambassadorships/1.json
  def destroy
    @ambassadorship.destroy
    respond_to do |format|
      format.html { redirect_to ambassadorships_url, notice: 'Ambassadorship was successfully destroyed.' }
      format.json { head :no_content }
      format.js {
        @ambassadorship = Ambassadorship.new(area: @ambassadorship.area)
        render :destroy
      }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ambassadorship
      @ambassadorship = Ambassadorship.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ambassadorship_params
      params.require(:ambassadorship).permit(:user_id, :area_id)
    end
end
