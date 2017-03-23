class CreatePhoneCalls < ActiveRecord::Migration
  def change
    create_table :phone_calls do |t|
      t.references :from_phone, index: true, foreign: { to_table: :phones }
      t.references :profile, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
