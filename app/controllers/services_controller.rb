class ServicesController < ApplicationController
  before_action :set_vendor, only: [:new]
  before_action :set_service, only: %i[show edit update destroy]

  # GET /services
  # GET /services.json
  def index
    @services = Service.all
  end

  # GET /services/1
  # GET /services/1.json
  def show; end

  # GET /services/new
  def new
    @service = @vendor.services.new
  end

  # GET /services/1/edit
  def edit; end

  # POST /services
  # POST /services.json
  def create
    @service = Service.new(service_params)

    respond_to do |format|
      if @service.save
        format.html { redirect_to @service.vendor.profile, notice: t('.notice') }
        format.json { render :show, status: :created, location: @service }
      else
        format.html { render :new }
        format.json { render json: @service.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /services/1
  # PATCH/PUT /services/1.json
  def update
    respond_to do |format|
      if @service.update(service_params)
        format.html { redirect_to @service, notice: t('.notice') }
        format.json { render :show, status: :ok, location: @service }
      else
        format.html { render :edit }
        format.json { render json: @service.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /services/1
  # DELETE /services/1.json
  def destroy
    @service.destroy
    respond_to do |format|
      format.html { redirect_to services_url, notice: t('.notice') }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_vendor
    @vendor = Vendor.find(params[:vendor_id])
  end

  def set_service
    @service = Service.find(params[:id])
  end

  # Never trust parameters from the scary internet,
  # only allow the white list through.
  def service_params
    params.require(:service).permit(:vendor_id, :name, :description, :price, :feature_photo)
  end
end
