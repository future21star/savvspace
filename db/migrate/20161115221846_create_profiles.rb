class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.references :profiled, polymorphic: true, index: true
      t.string :name
      t.text :bio
      t.string :contact_email
      t.string :linked_in
      t.string :facebook
      t.string :twitter
      t.string :instagram

      t.timestamps null: false
    end
  end
end
