class CreatePropertyNotes < ActiveRecord::Migration
  def change
    create_table :property_notes do |t|
      t.references :user, index: true, foreign_key: true
      t.references :property, index: true, foreign_key: true
      t.text :text

      t.timestamps null: false
    end
  end
end
