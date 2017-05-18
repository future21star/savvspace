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
    @property_search = OpenHouseSearch.find_or_create_by(search_params)
    @property_search.update(from_dates_list: date_params[:from_dates_list])

    @profile = @property_search.profile

    respond_to do |format|
      format.js
      format.html { render text: "ok" }
    end
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def search_params
      params.require(:open_house_search)
            .permit(:neighborhood, :sort_by, :min_price, :max_price, :min_beds, :max_beds, :to_date, :mls_server_id, :profile_id)
            .merge(mls_server: MlsServer.first)
            .inject({}) {|hash, (k,v)| hash.update(k => v.blank? ? nil : v)}
    end

    def date_params
      params.require(:open_house_search).permit(from_dates_list: [])
    end

end
