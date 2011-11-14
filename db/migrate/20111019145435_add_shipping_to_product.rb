class AddShippingToProduct < ActiveRecord::Migration
  def self.up
    add_column :products, :shipping, :boolean
  end

  def self.down
    remove_column :products, :shipping
  end
end
