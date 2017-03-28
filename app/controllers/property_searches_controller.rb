class PropertySearchesController < ApplicationController
  def create
    @property_search = PropertySearch.new(search_params)
    @results = Rets::PropertySearch.call(@property_search)

    respond_to do |format|
      format.js
    end
  end

  private

    def search_params
      params.require(:property_search).permit(:min_price, :max_price, :min_beds, :max_beds, :sort_by)
    end
end
