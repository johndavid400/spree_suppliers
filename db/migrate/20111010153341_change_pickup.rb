class ChangePickup < ActiveRecord::Migration
  def self.up
    add_column :pickups, :user_id, :integer
    remove_column :pickups, :name, :string
  end

  def self.down
    remove_column :pickups, :user_id
    add_column :pickups, :name, :string
  end
end
