class AddTitleToForumPost < ActiveRecord::Migration
  def change
    add_column :forum_posts, :title, :string
  end
end
