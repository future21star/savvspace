class RemoveFavoriteFromPropertySearches < ActiveRecord::Migration
  def change
    remove_column :property_searches, :favorite
  end
end
