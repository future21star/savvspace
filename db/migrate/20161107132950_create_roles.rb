class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :name, index: true, unique: true

      t.timestamps null: false
    end
  end
end
