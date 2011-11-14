class CreatePickups < ActiveRecord::Migration
  def self.up
    create_table :pickups do |t|
      t.string :name
      t.integer :address_id

      t.timestamps
    end
  end

  def self.down
    drop_table :pickups
  end
end
