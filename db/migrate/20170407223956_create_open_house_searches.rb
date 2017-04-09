class CreateOpenHouseSearches < ActiveRecord::Migration
  def change
    create_table :open_house_searches do |t|
      t.string :neighborhood
      t.integer :sort_by
      t.integer :min_price
      t.integer :max_price
      t.integer :min_beds
      t.integer :max_beds
      t.date :from_date
      t.date :to_date
      t.references :mls_server, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
