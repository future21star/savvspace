class FeatureRequestsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_feature_request, only: %i[show edit update destroy]

  # GET /feature_requests
  # GET /feature_requests.json
  def index
    authorize FeatureRequest
    @feature_requests = FeatureRequest.all
  end

  # GET /feature_requests/1
  # GET /feature_requests/1.json
  def show
    authorize @feature_request
  end

  # GET /feature_requests/new
  def new
    @feature = Feature.find(params[:feature_id])
    @feature_request = FeatureRequest.new(feature: @feature)
    authorize @feature_request
  end

  # GET /feature_requests/1/edit
  def edit
    authorize @feature_request
  end

  # POST /feature_requests
  # POST /feature_requests.json
  def create
    @feature_request = FeatureRequest.new(feature_request_params)
    authorize @feature_request

    @feature = @feature_request.feature
    @feature_request.user = current_user
    @feature_request.profile = current_user.profile

    respond_to do |format|
      if @feature_request.save
        format.html { redirect_to @feature_request, notice: t('.notice') }
        format.json { render :show, status: :created, location: @feature_request }
      else
        format.html { render :new }
        format.json { render json: @feature_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /feature_requests/1
  # PATCH/PUT /feature_requests/1.json
  def update
    authorize @feature_request

    respond_to do |format|
      if @feature_request.update(feature_request_params)
        format.html { redirect_to @feature_request, notice: t('.notice') }
        format.json { render :show, status: :ok, location: @feature_request }
      else
        format.html { render :edit }
        format.json { render json: @feature_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /feature_requests/1
  # DELETE /feature_requests/1.json
  def destroy
    authorize @feature_request

    @feature_request.destroy
    respond_to do |format|
      format.html { redirect_to feature_requests_url, notice: t('.notice') }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_feature_request
    @feature_request = FeatureRequest.find(params[:id])
  end

  # Never trust parameters from the scary internet,
  # only allow the white list through.
  def feature_request_params
    params.require(:feature_request).permit(:feature_id, :user_id, :profile_id,
                                            :agent_name, :broker_name, :broker_email)
  end
end
