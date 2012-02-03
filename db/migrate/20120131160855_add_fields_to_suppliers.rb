class AddFieldsToSuppliers < ActiveRecord::Migration
  def change
    add_column :suppliers, :name, :string
    add_column :suppliers, :title, :string
    add_column :suppliers, :phone, :string
    add_column :suppliers, :fax, :string
    add_column :suppliers, :email, :string
    add_column :suppliers, :website, :string
    add_column :suppliers, :notes, :text
    add_column :suppliers, :featured, :boolean
    add_column :suppliers, :twitter, :string
    add_column :suppliers, :facebook, :string
    add_column :suppliers, :description, :text
    add_column :suppliers, :user_id, :integer
  end
end
