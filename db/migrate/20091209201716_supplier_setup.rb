class SupplierSetup < ActiveRecord::Migration
  def self.up
    create_table :suppliers do |t|
      t.string :name
      t.string :address1
      t.string :address2
      t.string :city
      t.string :state_id
      t.string :zip_code
      t.string :phone
      t.string :fax
      t.string :email
      t.string :website
      t.text :notes
      
      t.timestamps
    end
    add_column :products, :supplier_id, :integer
  end

  def self.down
    drop_table :suppliers
    remove_column :products, :supplier_id
  end
end