class Location < ActiveRecord::Base
  attr_accessible :address, :latitude, :location_type, :longitude, :ride_id
  geocoded_by :address
  after_validation :geocode, :if => lambda{ |obj| obj.address_changed? }
  belongs_to :rides
end
