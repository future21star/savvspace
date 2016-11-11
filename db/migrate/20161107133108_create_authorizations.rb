class CreateAuthorizations < ActiveRecord::Migration
  def change
    create_table :authorizations do |t|
      t.references :user, index: true, foreign_key: true
      t.references :role, index: true, foreign_key: true
      t.references :authorizable, polymorphic: true, index: true

      t.timestamps null: false
    end
  end
end
