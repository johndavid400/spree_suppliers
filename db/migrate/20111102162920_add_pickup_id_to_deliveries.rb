class AddPickupIdToDeliveries < ActiveRecord::Migration
  def self.up
    add_column :deliveries, :pickup_id, :integer
  end

  def self.down
    remove_column :deliveries, :pickup_id
  end
end
