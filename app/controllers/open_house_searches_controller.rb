class OpenHouseSearchesController < ApplicationController

  def show
    @property_search = OpenHouseSearch.find(params[:id])
    @property_search.offset = params[:offset] || 0

    respond_to do |format|
      format.js
      format.html { render text: "ok" }
    end
  end

  def create
    normalized_params = search_params.merge(mls_server: MlsServer.first).
      inject({}) {|hash, (k,v)| hash.update(k => v.blank? ? nil : v)}

    @property_search = OpenHouseSearch.find_or_create_by(normalized_params)
    @profile = @property_search.profile
    @favorite = @property_search.favorite

    respond_to do |format|
      format.js
      format.html { render text: "ok" }
    end
  end


  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def search_params
      params.require(:open_house_search).permit(:neighborhood, :sort_by, :min_price, :max_price, :min_beds, :max_beds, :from_date, :to_date, :mls_server_id, :profile_id, :favorite)
    end
end
