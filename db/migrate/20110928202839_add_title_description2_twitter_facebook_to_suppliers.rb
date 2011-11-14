class AddTitleDescription2TwitterFacebookToSuppliers < ActiveRecord::Migration
  def self.up
    add_column :suppliers, :twitter, :string
    add_column :suppliers, :facebook, :string
    add_column :suppliers, :title, :string
    add_column :suppliers, :description2, :string
  end

  def self.down
    remove_column :suppliers, :description2
    remove_column :suppliers, :title
    remove_column :suppliers, :facebook
    remove_column :suppliers, :twitter
  end
end
