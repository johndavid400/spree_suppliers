class AddSupplierIdToSupplierInvoice < ActiveRecord::Migration
  def self.up
    add_column :supplier_invoices, :supplier_id, :integer
  end

  def self.down
    remove_column :supplier_invoices, :supplier_id
  end
end
