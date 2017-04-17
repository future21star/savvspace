class AddFieldsToProperty < ActiveRecord::Migration
  def change
    add_column :properties, :area, :string
    add_column :properties, :bedrooms, :integer, index: true
    add_column :properties, :city, :string
    add_column :properties, :construction, :string
    add_column :properties, :county, :string
    add_column :properties, :days_on_market, :integer
    add_column :properties, :full_baths, :integer, index: true
    add_column :properties, :half_baths, :integer
    add_column :properties, :heating, :string
    add_column :properties, :list_price, :integer, index: true
    add_column :properties, :listing_member_email, :string
    add_column :properties, :listing_member_name, :string
    add_column :properties, :listing_member_phone, :string
    add_column :properties, :listing_member_url, :string
    add_column :properties, :listing_office_address, :string
    add_column :properties, :listing_office_name, :string
    add_column :properties, :listing_office_phone, :string
    add_column :properties, :lat, :string
    add_column :properties, :lng, :string
    add_column :properties, :internal_mls_id, :string, index: true
    add_column :properties, :listing_id, :string, index: true
    add_column :properties, :open_houses, :jsonb
    add_column :properties, :parking, :string
    add_column :properties, :photos, :text, array: true, default: []
    add_column :properties, :public_remarks, :string
    add_column :properties, :square_feet, :integer
    add_column :properties, :state, :string
    add_column :properties, :status, :string
    add_column :properties, :street_address, :string
    add_column :properties, :style, :string
    add_column :properties, :topography, :string
    add_column :properties, :property_type, :string
    add_column :properties, :year_built, :string
    add_column :properties, :zip5, :string
    add_column :properties, :zoning, :string
    add_column :properties, :mls_updated_at, :datetime, index: true
    add_column :properties, :parcel_number, :string
    add_column :properties, :elementary_school, :string
    add_column :properties, :junior_high_school, :string
    add_column :properties, :high_school, :string
  end
end
