class Item < ActiveRecord::Base
  belongs_to :supplier_invoice
  belongs_to :product
  belongs_to :line_item
end
