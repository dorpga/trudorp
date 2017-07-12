class RemoveAuthorFromForumPost < ActiveRecord::Migration
  def change
    remove_reference :forum_posts, :author, index: true, foreign_key: true
  end
end
