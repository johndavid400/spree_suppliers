class AddAttributesToAssets < ActiveRecord::Migration
  def self.up
    add_column :assets, :logo, :boolean
    add_column :assets, :featured, :boolean
  end

  def self.down
    remove_column :assets, :logo
    remove_column :assets, :featured
  end
end
