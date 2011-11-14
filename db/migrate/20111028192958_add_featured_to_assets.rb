class AddFeaturedToAssets < ActiveRecord::Migration
  def self.up
    add_column :assets, :featured, :boolean
  end

  def self.down
    remove_column :assets, :featured
  end
end
