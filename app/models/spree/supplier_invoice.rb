class Spree::SupplierInvoice < ActiveRecord::Base
  belongs_to :supplier
  has_many :invoice_items
end
