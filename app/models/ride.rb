class Ride < ActiveRecord::Base
  attr_accessible :depart_date, :source, :preferences, :return_date, :destination, :who
end
