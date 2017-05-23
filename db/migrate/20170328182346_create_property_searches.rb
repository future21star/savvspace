class CreatePropertySearches < ActiveRecord::Migration
  def change
    create_table :property_searches do |t|
      t.integer :min_price
      t.integer :max_price
      t.integer :min_beds
      t.integer :max_beds
      t.integer :min_baths
      t.integer :sort_by

      t.timestamps null: false
    end
  end
end
