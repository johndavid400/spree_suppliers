class CreateSupplierInvoices < ActiveRecord::Migration
  def self.up
    create_table :supplier_invoices do |t|
      t.integer :order_id
      t.integer :item_count
      t.string :invoice_total

      t.timestamps
    end
  end

  def self.down
    drop_table :supplier_invoices
  end
end
