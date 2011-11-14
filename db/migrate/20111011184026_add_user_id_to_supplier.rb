class AddUserIdToSupplier < ActiveRecord::Migration
  def self.up
    add_column :suppliers, :user_id, :integer
  end

  def self.down
    remove_column :suppliers, :user_id
  end
end
