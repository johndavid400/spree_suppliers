class Delivery < ActiveRecord::Base
  belongs_to :order
  belongs_to :supplier
  has_one :pickup
  belongs_to :shipping_method
end
