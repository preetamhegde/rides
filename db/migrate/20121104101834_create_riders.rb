class CreateRiders < ActiveRecord::Migration
  def change
    create_table :riders do |t|
      t.string :name
      t.string :phone
      t.string :address

      t.timestamps
    end
  end
end
