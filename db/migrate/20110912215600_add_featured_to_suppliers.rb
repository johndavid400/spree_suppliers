class AddFeaturedToSuppliers < ActiveRecord::Migration
  def self.up
    add_column :suppliers, :featured, :boolean
  end

  def self.down
    remove_column :suppliers, :featured
  end
end
