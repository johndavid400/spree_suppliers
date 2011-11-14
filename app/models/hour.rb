class Hour < ActiveRecord::Base
  belongs_to :supplier
  belongs_to :pickup_location
end
