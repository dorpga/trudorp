class AddForeignToForumPosts < ActiveRecord::Migration
  def change
    add_reference :forum_posts, :forum_thread, index: true, foreign_key: true
  end
end
