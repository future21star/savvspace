class CreateServiceAreas < ActiveRecord::Migration
  def change
    create_table :service_areas do |t|
      t.belongs_to :vendor, index: true, foreign_key: true
      t.belongs_to :area, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
