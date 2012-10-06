class RenameColumnInRides < ActiveRecord::Migration
  def up
    rename_column :rides, :from, :source
    rename_column :rides, :to, :destination
  end

  def down
    rename_column :rides, :source, :from
    rename_column :rides, :destination, :to
  end
end
