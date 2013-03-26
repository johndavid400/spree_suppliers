class CreateSuppliers < ActiveRecord::Migration
  def change
    create_table :spree_suppliers do |t|

      t.timestamps
    end
  end
end
