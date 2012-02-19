class CreateInvoiceItems < ActiveRecord::Migration
  def change
    create_table :spree_invoice_items do |t|
      t.integer :spree_product_id
      t.integer :quantity
      t.integer :spree_supplier_invoice_id
      t.integer :spree_line_item_id

      t.timestamps
    end
  end
end
