class AddProfileIdToOpenHouseSearches < ActiveRecord::Migration
  def change
    add_reference :open_house_searches, :profile, index: true, foreign_key: true
  end
end
