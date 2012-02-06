class Supplier < ActiveRecord::Base
  validates_presence_of :name, :title
  validates_uniqueness_of :name, :title
  has_many :images, :as => :viewable, :order => :position, :dependent => :destroy
  accepts_nested_attributes_for :images
  has_one :user
  has_many :supplier_invoices
  has_and_belongs_to_many :taxons
  has_many :products
end
