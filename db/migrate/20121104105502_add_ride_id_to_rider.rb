class AddRideIdToRider < ActiveRecord::Migration
  def change
    add_column :riders, :ride_id, :integer
  end
end
