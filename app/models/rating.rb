class Rating < ActiveRecord::Base
  validates :value, :presence => true
  belongs_to :product
  belongs_to :supplier
  belongs_to :article
  belongs_to :recipe
  belongs_to :comment
end
