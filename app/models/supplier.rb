class Supplier < ActiveRecord::Base
  validates :title, :presence => true
#  scope :current_city, lambda {|id| where("city_id", id)}
  acts_as_gmappable :check_process => false
  acts_as_url :title, :url_attribute => :slug, :scope => :state_id

  def gmaps4rails_address
    country = State.find_by_id(self.state_id).country.name
    "#{self.address1}, #{self.town}, #{self.state.name}, #{self.zip_code}"
  end

  def gmaps4rails_title 
    self.name
  end

  def gmaps4rails_infowindow
    "<a href='/#{self.state.abbr}/#{self.slug}'>#{self.title}</a>"
  end

  belongs_to :state
  has_one :user
  has_many :products
  has_many :messages
  has_many :hours
  has_many :pickups
  has_many :pickup_locations
  has_many :images, :as => :viewable, :order => :position, :dependent => :destroy
  accepts_nested_attributes_for :hours
  has_many :supplier_invoices
  has_and_belongs_to_many :taxons
  has_and_belongs_to_many :shipping_methods
  has_many :deliveries
end
