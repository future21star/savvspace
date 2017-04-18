class AddProfileIdToPropertySearch < ActiveRecord::Migration
  def change
    add_reference :property_searches, :profile, index: true, foreign_key: true
    add_column :property_searches, :property_type, :string
    add_column :property_searches, :area, :string
  end
end
