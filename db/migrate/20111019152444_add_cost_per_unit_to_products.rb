class AddCostPerUnitToProducts < ActiveRecord::Migration
  def self.up
    add_column :products, :cost_per_unit, :decimal
  end

  def self.down
    remove_column :products, :cost_per_unit
  end
end
