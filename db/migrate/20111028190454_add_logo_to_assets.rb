class AddLogoToAssets < ActiveRecord::Migration
  def self.up
    add_column :assets, :logo, :boolean
  end

  def self.down
    remove_column :assets, :logo
  end
end
