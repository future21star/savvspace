class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def index
    @item_type = item_type
    @items = item.favored_by(current_user)
  end

  private

  def item_type
    params[:item_type] == 'open_house' ? 'open_house' : 'property'
  end

  def item
    item_type.camelize.constantize
  end
end
