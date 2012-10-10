class Ride < ActiveRecord::Base
  attr_accessible :depart_date, :preferences, :return_date, :who, :source, :destination
  belongs_to :user
  has_many :locations

  def source
    source_location = self.locations.where(:location_type => 'source').first
    return source_location.address if source_location
    return nil
  end

  def source=(params)
  end

  def destination
    destination_location = self.locations.where(:location_type => 'destination').first
    return destination_location.address if destination_location
    return nil
  end

  def destination=(params)
  end
end
