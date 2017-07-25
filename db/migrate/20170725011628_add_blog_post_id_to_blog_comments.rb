class AddBlogPostIdToBlogComments < ActiveRecord::Migration
  def change
    add_column :blog_comments, :blog_post_id, :integer
  end
end
