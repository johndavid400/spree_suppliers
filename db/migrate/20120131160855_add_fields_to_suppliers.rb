class AddFieldsToSuppliers < ActiveRecord::Migration
  def change
    add_column :spree_suppliers, :name, :string
    add_column :spree_suppliers, :title, :string
    add_column :spree_suppliers, :phone, :string
    add_column :spree_suppliers, :fax, :string
    add_column :spree_suppliers, :email, :string
    add_column :spree_suppliers, :website, :string
    add_column :spree_suppliers, :notes, :text
    add_column :spree_suppliers, :featured, :boolean
    add_column :spree_suppliers, :twitter, :string
    add_column :spree_suppliers, :facebook, :string
    add_column :spree_suppliers, :description, :text
    add_column :spree_suppliers, :spree_user_id, :integer
  end
end
