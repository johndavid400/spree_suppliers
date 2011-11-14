class CreatePickupLocations < ActiveRecord::Migration
  def self.up
    create_table :pickup_locations do |t|
      t.string :location_name
      t.string :address1
      t.string :address2
      t.string :city
      t.integer :state_id
      t.string :zipcode
      t.integer :country_id
      t.integer :supplier_id
      t.boolean :featured

      t.timestamps
    end
  end

  def self.down
    drop_table :pickup_locations
  end
end
