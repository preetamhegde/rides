class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.integer :ride_id
      t.string :address
      t.float :latitude
      t.float :longitude
      t.string :location_type

      t.timestamps
    end
  end
end
