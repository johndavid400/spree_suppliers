class AddSupplierIdToProducts < ActiveRecord::Migration
  def change
    add_column :products, :supplier_id, :integer
  end
end
