class AddCoordinatesToSuppliers < ActiveRecord::Migration
  def self.up
    add_column :suppliers, :latitude, :float
    add_column :suppliers, :longitude, :float
  end

  def self.down
    remove_column :suppliers, :longitude
    remove_column :suppliers, :latitude
  end
end
