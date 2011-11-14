class AddNumberOfUnitsToProducts < ActiveRecord::Migration
  def self.up
    add_column :products, :number_of_units, :decimal
  end

  def self.down
    remove_column :products, :number_of_units
  end
end
