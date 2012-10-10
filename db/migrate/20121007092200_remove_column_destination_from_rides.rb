class RemoveColumnDestinationFromRides < ActiveRecord::Migration
  def up
    remove_column :rides, :destination
  end

  def down
    add_column :rides, :destination, :string
  end
end
