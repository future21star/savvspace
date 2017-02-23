class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.references :vendor, index: true, foreign_key: true
      t.string :name
      t.text :description
      t.integer :price

      t.timestamps null: false
    end
  end
end
