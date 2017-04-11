class CreateOpenHouses < ActiveRecord::Migration
  def change
    create_table :open_houses do |t|
      t.references :mls_server, index: true, foreign_key: true
      t.string :street_address
      t.string :state
      t.string :city
      t.string :area
      t.string :mls_event_id
      t.datetime :starts_at
      t.datetime :ends_at
      t.datetime :mls_updated_at
      t.string :host_name
      t.string :host_phone
      t.string :mls_property_id
      t.integer :list_price
      t.string :list_agent_id
      t.string :list_agent_first_name
      t.string :list_agent_last_name
      t.string :list_office_id
      t.string :list_office_name
      t.text :comments
      t.string :list_agent_phone
      t.string :list_office_phone
      t.string :photo_url

      t.jsonb :raw_listing

      t.timestamps null: false
    end
    add_index :open_houses, :area
  end
end
