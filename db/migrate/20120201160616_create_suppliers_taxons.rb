class CreateSuppliersTaxons < ActiveRecord::Migration
  def self.up
    create_table :spree_suppliers_taxons, :id => false do |t|
      t.integer :supplier_id
      t.integer :taxon_id
    end
    add_index :spree_suppliers_taxons, :supplier_id
    add_index :spree_suppliers_taxons, :taxon_id
  end

  def self.down
    remove_index :spree_suppliers_taxons, :column => :taxon_id
    remove_index :spree_suppliers_taxons, :column => :supplier_id
    drop_table :spree_suppliers_taxons
  end
end
