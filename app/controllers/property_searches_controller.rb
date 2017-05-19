class PropertySearchesController < ApplicationController
  def show
    @property_search = PropertySearch.find(params[:id])
    @property_search.offset = params[:offset] || 0

    respond_to do |format|
      format.js
      format.html { render text: 'ok' }
    end
  end

  def create
    normalized_params = search_params
                        .merge(mls_server: MlsServer.first)
                        .inject({}) { |hash, (k, v)| hash.update(k => v.blank? ? nil : v) }

    @property_search = PropertySearch.find_or_create_by(normalized_params)
    @profile = @property_search.profile
    @favorite = @property_search.favorite

    respond_to do |format|
      format.js
      format.html { render text: 'ok' }
    end
  end

  private

    def search_params
      params.require(:property_search).permit(:profile_id, :min_price, :max_price,
                                              :min_beds, :max_beds, :sort_by, :mls_server_id,
                                              :property_type, :area, :offset, :limit, :favorite)
    end
end
