class CreatePhotoAlbums < ActiveRecord::Migration
  def change
    create_table :photo_albums do |t|
      t.references :owner, polymorphic: true, index: true

      t.timestamps null: false
    end
  end
end
