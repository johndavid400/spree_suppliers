class AddUnitToProducts < ActiveRecord::Migration
  def self.up
    add_column :products, :unit, :string
  end

  def self.down
    remove_column :products, :unit
  end
end
