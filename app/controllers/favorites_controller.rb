class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def index
    @item_type = params[:item_type] || 'property'
    @items = current_user.favorite_items.send(@item_type.pluralize).collect(&:favorite)
  end
end
