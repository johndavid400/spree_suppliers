class SupplierInvoice < ActiveRecord::Base
  has_many :items
  belongs_to :order
  belongs_to :supplier
end
