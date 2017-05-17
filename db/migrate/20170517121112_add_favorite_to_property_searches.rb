class AddFavoriteToPropertySearches < ActiveRecord::Migration
  def change
    add_column :property_searches, :favorite, :boolean, default: false
  end
end
