class CreateMlsServers < ActiveRecord::Migration
  def change
    create_table :mls_servers do |t|
      t.string :name
      t.string :server_hash

      t.timestamps null: false
    end
    add_index :mls_servers, :name
  end
end
