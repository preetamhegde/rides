class AddSeatsToRide < ActiveRecord::Migration
  def change
    add_column :rides, :seats, :integer
  end
end
