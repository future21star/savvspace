class AddMlsAdapterToMlsServer < ActiveRecord::Migration
  def change
    add_reference :mls_servers, :mls_adapter, index: true, foreign_key: true
  end
end
