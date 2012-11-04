class Rider < ActiveRecord::Base
  attr_accessible :address, :name, :phone, :ride_id
  belongs_to :ride
end
