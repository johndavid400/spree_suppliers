class AddPickupLocationIdToHours < ActiveRecord::Migration
  def self.up
    add_column :hours, :pickup_location_id, :integer
  end

  def self.down
    remove_column :hours, :pickup_location_id
  end
end
