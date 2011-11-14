class AddCommentIdToRating < ActiveRecord::Migration
  def self.up
    add_column :ratings, :comment_id, :integer
  end

  def self.down
    remove_column :ratings, :comment_id
  end
end
