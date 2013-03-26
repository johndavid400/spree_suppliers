class AddSupplierIdToProducts < ActiveRecord::Migration
  def change
    add_column :spree_products, :spree_supplier_id, :integer
  end
end
