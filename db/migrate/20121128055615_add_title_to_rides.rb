class AddTitleToRides < ActiveRecord::Migration
  def change
    add_column :rides, :title, :string
  end
end
