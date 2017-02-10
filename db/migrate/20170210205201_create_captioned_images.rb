class CreateCaptionedImages < ActiveRecord::Migration
  def change
    create_table :captioned_images do |t|
      t.string :caption
      t.references :owner, polymorphic: true, index: true

      t.timestamps null: false
    end
  end
end
