class CreateMessages < ActiveRecord::Migration
  def self.up
    create_table :messages do |t|
      t.integer :supplier_id
      t.string :title
      t.string :text
      t.integer :user_id
      t.boolean :opened
      t.string :author

      t.timestamps
    end
  end

  def self.down
    drop_table :messages
  end
end
