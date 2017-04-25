class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :from_id
      t.integer :to_id
      t.references :conversation, index: true, foreign_key: true
      t.text :body
      t.datetime :read_at

      t.timestamps null: false
    end
  end
end
