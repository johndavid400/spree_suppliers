class ChangeInvoiceTotalOnSupplierInvoices < ActiveRecord::Migration
  def self.up
    change_column :supplier_invoices, :invoice_total, :decimal, :precision => 8, :scale => 2, :default => 0.0, :null => false
  end

  def self.down
    change_column :supplier_invoices, :invoice_total
  end
end
