class ChangeItemInvoiceTotalToDecimal < ActiveRecord::Migration
  def self.up
    change_column :supplier_invoices, :invoice_total, :decimal
  end

  def self.down
    change_column :supplier_invoices, :invoice_total
  end
end
