class AddPropertyIdToOpenHouse < ActiveRecord::Migration
  def change
    add_reference :open_houses, :property, index: true, foreign_key: true
  end
end
