class AddPickupToAddresses < ActiveRecord::Migration
  def self.up
    add_column :addresses, :pickup, :boolean
  end

  def self.down
    remove_column :addresses, :pickup
  end
end
