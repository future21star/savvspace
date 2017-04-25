class CreateConversations < ActiveRecord::Migration
  def change
    create_table :conversations do |t|
      t.integer :initiator_id, index: true
      t.integer :recipient_id, index: true

      t.timestamps null: false
    end
  end
end
