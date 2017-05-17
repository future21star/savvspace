class AddFavoriteToOpenHouseSearches < ActiveRecord::Migration
  def change
    add_column :open_house_searches, :favorite, :boolean, default: false
  end
end
