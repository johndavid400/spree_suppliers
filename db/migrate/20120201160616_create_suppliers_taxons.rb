class CreateSuppliersTaxons < ActiveRecord::Migration
  def self.up
    create_table :spree_suppliers_taxons, :id => false do |t|
      t.integer :spree_supplier_id
      t.integer :spree_taxon_id
    end
    add_index :spree_suppliers_taxons, :spree_supplier_id
    add_index :spree_suppliers_taxons, :spree_taxon_id
  end

  def self.down
    remove_index :spree_suppliers_taxons, :column => :spree_taxon_id
    remove_index :spree_suppliers_taxons, :column => :spree_supplier_id
    drop_table :spree_suppliers_taxons
  end
end
