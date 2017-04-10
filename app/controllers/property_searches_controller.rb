class PropertySearchesController < ApplicationController
  def create
    @property_search = PropertySearch.new(search_params)
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
      params.require(:property_search).permit(:min_price, :max_price, :min_beds, :max_beds, :sort_by)
    end
end
