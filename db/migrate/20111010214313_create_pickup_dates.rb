class CreatePickupDates < ActiveRecord::Migration
  def self.up
    create_table :pickup_dates do |t|
      t.datetime :day
      t.integer :pickup_id

      t.timestamps
    end
  end

  def self.down
    drop_table :pickup_dates
  end
end
