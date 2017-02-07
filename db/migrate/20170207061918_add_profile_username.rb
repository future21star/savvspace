class AddProfileUsername < ActiveRecord::Migration
  def change
    add_column :profiles, :username, :string, index: true, unique: true
  end
end
