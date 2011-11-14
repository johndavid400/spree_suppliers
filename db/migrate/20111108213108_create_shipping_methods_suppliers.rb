class CreateShippingMethodsSuppliers < ActiveRecord::Migration
  def self.up
    create_table :shipping_methods_suppliers, :id => false do |t|
      t.integer :supplier_id
      t.integer :shipping_method_id
    end
    add_index :shipping_methods_suppliers, :supplier_id
    add_index :shipping_methods_suppliers, :shipping_method_id
  end

  def self.down
    remove_index :shipping_methods_suppliers, :column => :shipping_method_id
    remove_index :shipping_methods_suppliers, :column => :supplier_id
    drop_table :shipping_methods_suppliers
  end
end
