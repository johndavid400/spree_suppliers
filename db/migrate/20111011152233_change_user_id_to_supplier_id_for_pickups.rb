class ChangeUserIdToSupplierIdForPickups < ActiveRecord::Migration
  def self.up
    add_column :pickups, :supplier_id, :integer
    remove_column :pickups, :user_id, :integer
  end

  def self.down
    remove_column :pickups, :supplier_id, :integer
    add_column :pickups, :user_id, :integer
  end
end
