class AddGmapsToSuppliers < ActiveRecord::Migration
  def self.up
    add_column :suppliers, :gmaps, :boolean
  end

  def self.down
    remove_column :suppliers, :gmaps
  end
end
