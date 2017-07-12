class AddBodyToForumPost < ActiveRecord::Migration
  def change
    add_column :forum_posts, :body, :text
  end
end
