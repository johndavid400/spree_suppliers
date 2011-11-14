class AddSupplierIdToPickups < ActiveRecord::Migration
  def self.up
    add_column :pickups, :supplier_id, :integer
    remove_column :pickups, :address_id
  end

  def self.down
    add_column :pickups, :address_id, :integer
    remove_column :pickups, :supplier_id
  end
end
