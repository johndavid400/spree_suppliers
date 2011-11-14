class AddDeliveryIdToPickups < ActiveRecord::Migration
  def self.up
    add_column :pickups, :delivery_id, :integer
  end

  def self.down
    remove_column :pickups, :delivery_id
  end
end
