class OpenHouseSearchesController < ApplicationController
  def create
    @property_search = OpenHouseSearch.new(open_house_search_params)
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

    # Never trust parameters from the scary internet, only allow the white list through.
    def open_house_search_params
      params.require(:open_house_search).permit(:neighborhood, :sort_by, :min_price, :max_price, :min_beds, :max_beds, :from_date, :to_date, :mls_server_id)
    end
end
