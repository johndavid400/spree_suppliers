class AddPickupLocationIdToPickups < ActiveRecord::Migration
  def self.up
    add_column :pickups, :pickup_location_id, :integer
  end

  def self.down
    remove_column :pickups, :pickup_location_id
  end
end
