class ChangeSuppliersCityToTown < ActiveRecord::Migration
  def self.up
    rename_column :suppliers, :city, :town
  end

  def self.down
    rename_column :suppliers, :town, :city
  end
end
