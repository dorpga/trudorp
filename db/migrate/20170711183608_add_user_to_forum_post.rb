class AddUserToForumPost < ActiveRecord::Migration
  def change
    add_column :forum_posts, :user, :reference
  end
end
