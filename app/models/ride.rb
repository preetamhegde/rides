class Ride < ActiveRecord::Base
  attr_accessible :depart_date, :preferences, :return_date, :who, :source, :destination, :seats, :title
  belongs_to :user
  has_many :sources
  has_many :destinations
  has_many :riders

  def source
    source_location = self.sources.first
    return source_location.address if source_location
    return nil
  end

  def source=(params)
  end

  def destination
    destination_location = self.destinations.first
    return destination_location.address if destination_location
    return nil
  end

  def destination=(params)
  end

  def seat_available?
    return false if self.seats.nil?
    return self.seats > 0
  end
end
