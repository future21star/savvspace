class CreateProperties < ActiveRecord::Migration
  def change
    create_table :properties do |t|
      t.references :mls_server, index: true, foreign_key: true
      t.jsonb :mls_data

      t.timestamps null: false
    end
  end
end
