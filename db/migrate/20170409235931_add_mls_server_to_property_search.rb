class AddMlsServerToPropertySearch < ActiveRecord::Migration
  def change
    add_reference :property_searches, :mls_server, index: true, foreign_key: true
  end
end
