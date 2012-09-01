class CreateSuppliers < ActiveRecord::Migration
  def change
    create_table :spree_suppliers do |t|
      t.string :name
      t.string :title
      t.string :phone
      t.string :fax
      t.string :email
      t.string :website
      t.text :notes
      t.boolean :featured
      t.string :twitter
      t.string :facebook
      t.text :description
      t.integer :user_id

      t.timestamps
    end
  end
end
