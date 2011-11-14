class AddShippingMethodIdToDeliveries < ActiveRecord::Migration
  def self.up
    add_column :deliveries, :shipping_method_id, :integer
  end

  def self.down
    remove_column :deliveries, :shipping_method_id
  end
end
