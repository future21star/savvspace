class AddReferrerProfileRefferenceToFavoriteItems < ActiveRecord::Migration
  def change
    add_column :favorite_items, :referrer_profile_id, :integer, index: true, foreign_key: true
  end
end
