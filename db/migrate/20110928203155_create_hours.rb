class CreateHours < ActiveRecord::Migration
  def self.up
    create_table :hours do |t|
      t.string :monday
      t.string :tuesday
      t.string :wednesday
      t.string :thursday
      t.string :friday
      t.string :saturday
      t.string :sunday
      t.integer :supplier_id
      t.integer :pickup_location_id

      t.timestamps
    end
  end

  def self.down
    drop_table :cities
  end
end
