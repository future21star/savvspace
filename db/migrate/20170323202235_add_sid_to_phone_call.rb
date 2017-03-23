class AddSidToPhoneCall < ActiveRecord::Migration
  def change
    add_column :phone_calls, :sid, :string, index: true
  end
end
