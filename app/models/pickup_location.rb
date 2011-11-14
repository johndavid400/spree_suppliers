class PickupLocation < ActiveRecord::Base
  has_many :pickups
  belongs_to :supplier
  scope :locate, :conditions => { :featured => true}
  has_many :hours
  accepts_nested_attributes_for :hours
end
