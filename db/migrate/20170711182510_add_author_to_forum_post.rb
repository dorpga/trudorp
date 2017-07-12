class AddAuthorToForumPost < ActiveRecord::Migration
  def change
    add_reference :forum_posts, :author, index: true, foreign_key: true
  end
end
