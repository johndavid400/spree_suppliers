class Supplier < ActiveRecord::Base
  has_many :images, :as => :viewable, :order => :position, :dependent => :destroy
  accepts_nested_attributes_for :images
  belongs_to :user
  has_many :supplier_invoices
  has_and_belongs_to_many :taxons
  has_many :products
end
