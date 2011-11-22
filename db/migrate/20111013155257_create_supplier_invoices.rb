class CreateSupplierInvoices < ActiveRecord::Migration
  def self.up
    create_table :supplier_invoices do |t|
      t.integer :order_id
      t.integer :item_count
      t.integer :supplier_id
      t.decimal :invoice_total, :precision => 8, :scale => 2, :default => 0.0, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :supplier_invoices
  end
end
