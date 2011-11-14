class AddCityToSuppliers < ActiveRecord::Migration
  def self.up
    add_column :suppliers, :city_id, :integer
  end

  def self.down
    remove_column :suppliers, :city_id
  end
end
