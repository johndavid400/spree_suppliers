class Spree::Supplier < ActiveRecord::Base
  attr_accessible :title, :notes, :phone, :fax, :email, :facebook, :twitter, :website, :name, :image, :image_file_name
  has_many :images, :class_name=> 'Spree::Image', :as => :viewable, :order => :position, :dependent => :destroy
  accepts_nested_attributes_for :images
  belongs_to :user
  has_many :supplier_invoices
  has_and_belongs_to_many :taxons
  has_many :products
end
