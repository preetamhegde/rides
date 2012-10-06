class CreateRides < ActiveRecord::Migration
  def change
    create_table :rides do |t|
      t.string :from
      t.string :to
      t.datetime :depart_date
      t.datetime :return_date
      t.string :preferences
      t.string :who

      t.timestamps
    end
  end
end
