class AddPickupIdToPickupDate < ActiveRecord::Migration
  def self.up
    add_column :pickup_dates, :pickup_id, :integer
  end

  def self.down
    remove_column :pickup_dates, :pickup_id
  end
end
