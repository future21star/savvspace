class CreateFavoriteItems < ActiveRecord::Migration
  def change
    create_table :favorite_items do |t|
      t.references :favorite, polymorphic: true, index: true
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
