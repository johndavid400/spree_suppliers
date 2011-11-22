class AddLocationToAddresses < ActiveRecord::Migration
  def self.up
    add_column :addresses, :location, :boolean
  end

  def self.down
    remove_column :addresses, :location
  end
end
