class AddProductsSoldToSuppliers < ActiveRecord::Migration
  def self.up
    add_column :suppliers, :products_sold, :text
  end

  def self.down
    remove_column :suppliers, :products_sold
  end
end
