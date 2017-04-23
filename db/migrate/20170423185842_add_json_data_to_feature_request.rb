class AddJsonDataToFeatureRequest < ActiveRecord::Migration
  def change
    add_column :feature_requests, :extra_data, :jsonb, default: {}
  end
end
