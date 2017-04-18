class PropertySearchesController < ApplicationController
  def create
    @property_search = PropertySearch.new(search_params)
    @profile = @property_search.profile
    @property_search.mls_server = MlsServer.first
    if @property_search.valid?
      @results = @property_search.results
    else
      @results = []
    end

    respond_to do |format|
      format.js
    end
  end

  private

    def search_params
      params.require(:property_search).permit(:profile_id, :min_price, :max_price, :min_beds, :max_beds, :sort_by, :mls_server_id, :property_type, :area)
    end
end
