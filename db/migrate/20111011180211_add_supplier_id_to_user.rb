class AddSupplierIdToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :supplier_id, :integer
  end

  def self.down
    remove_column :users, :supplier_id
  end
end
