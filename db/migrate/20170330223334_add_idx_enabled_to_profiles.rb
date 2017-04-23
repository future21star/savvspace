class AddIdxEnabledToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :idx_enabled, :boolean, default: false
  end
end
