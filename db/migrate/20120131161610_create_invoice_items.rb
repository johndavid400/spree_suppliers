class CreateInvoiceItems < ActiveRecord::Migration
  def change
    create_table :invoice_items do |t|
      t.integer :product_id
      t.integer :quantity
      t.integer :supplier_invoice_id
      t.integer :line_item_id

      t.timestamps
    end
  end
end
