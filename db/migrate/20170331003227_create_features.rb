class CreateFeatures < ActiveRecord::Migration
  def change
    create_table :features do |t|
      t.string :name, index: true
      t.text :description
      t.datetime :enabled_at
      t.datetime :disabled_at

      t.timestamps null: false
    end
  end
end
