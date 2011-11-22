class AddAttributesToProducts < ActiveRecord::Migration
  def self.up
    add_column :products, :number_of_units, :decimal
    add_column :products, :unit, :string
    add_column :products, :cost_per_unit, :decimal
    add_column :products, :shipping_method_id, :integer
    add_column :products, :shipping, :boolean
  end

  def self.down
    remove_column :products, :number_of_units
    remove_column :products, :unit
    remove_column :products, :cost_per_unit
    remove_column :products, :shipping_method_id
    remove_column :products, :shipping
  end
end
