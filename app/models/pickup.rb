class Pickup < ActiveRecord::Base
  belongs_to :pickup_location
  has_many :pickup_dates
  belongs_to :supplier
  belongs_to :delivery

  def location_name 
    self.pickup_location.location_name
  end
end
