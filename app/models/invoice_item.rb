class InvoiceItem < ActiveRecord::Base
  belongs_to :supplier_invoice
  belongs_to :line_item
end
