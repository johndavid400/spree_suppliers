class CreatePickups < ActiveRecord::Migration
  def self.up
    create_table :pickups do |t|
      t.string :name
      t.integer :address_id
      t.integer :supplier_id
      t.integer :pickup_location_id
      t.integer :delivery_id

      t.timestamps
    end
  end

  def self.down
    drop_table :pickups
  end
end
