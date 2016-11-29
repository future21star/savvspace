class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.references :user, index: true, foreign_key: true
      t.references :rateable, polymorphic: true, index: true
      t.float :rating, null: false, default: 0

      t.timestamps null: false
    end
  end
end
