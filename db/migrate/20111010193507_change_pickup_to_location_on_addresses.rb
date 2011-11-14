class ChangePickupToLocationOnAddresses < ActiveRecord::Migration
  def self.up
    add_column :addresses, :location, :boolean
    remove_column :addresses, :pickup, :boolean
  end

  def self.down
    remove_column :addresses, :location
    add_column :addresses, :pickup
  end
end
