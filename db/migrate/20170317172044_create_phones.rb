class CreatePhones < ActiveRecord::Migration
  def change
    create_table :phones do |t|
      t.string :number
      t.references :owner, polymorphic: true, index: true

      t.timestamps null: false
    end
  end
end
