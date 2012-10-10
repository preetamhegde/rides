class RemoveColumnFromRides < ActiveRecord::Migration
  def up
    remove_column :rides, :source
  end

  def down
    add_column :rides, :source, :string
  end
end
