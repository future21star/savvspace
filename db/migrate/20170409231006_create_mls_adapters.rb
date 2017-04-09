class CreateMlsAdapters < ActiveRecord::Migration
  def change
    create_table :mls_adapters do |t|
      t.string :type

      t.timestamps null: false
    end
  end
end
