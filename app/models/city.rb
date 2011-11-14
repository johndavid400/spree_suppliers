class City < ActiveRecord::Base
  acts_as_url :name, :url_attribute => :slug, :scope => :state_id

  has_many :suppliers
  has_many :articles
  has_many :recipes
  has_one :user
  belongs_to :state
end
