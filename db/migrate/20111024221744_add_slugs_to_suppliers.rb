class AddSlugsToSuppliers < ActiveRecord::Migration
  def self.up
    add_column :suppliers, :slug, :string
  end

  def self.down
    remove_column :suppliers, :slug
  end
end
