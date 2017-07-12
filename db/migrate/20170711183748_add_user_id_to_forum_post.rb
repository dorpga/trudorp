class AddUserIdToForumPost < ActiveRecord::Migration
  def change
    add_column :forum_posts, :user_id, :integer
  end
end
