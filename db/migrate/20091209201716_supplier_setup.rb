class SupplierSetup < ActiveRecord::Migration
  def self.up
    create_table :suppliers do |t|
      t.string :name
      t.string :title
      t.string :description2
      t.string :address1
      t.string :address2
      t.string :town
      t.string :state_id
      t.string :zip_code
      t.string :phone
      t.string :fax
      t.string :email
      t.string :website
      t.string :twitter
      t.string :facebook
      t.text :notes
      t.text :products_sold
      t.float :latitude
      t.float :longitude
      t.boolean :gmaps
      t.boolean :featured
      t.string :slug
      t.integer :user_id

      t.timestamps
    end
    add_column :products, :supplier_id, :integer
  end

  def self.down
    drop_table :suppliers
    remove_column :products, :supplier_id
  end
end
