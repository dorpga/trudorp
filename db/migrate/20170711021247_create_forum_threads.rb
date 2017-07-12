class CreateForumThreads < ActiveRecord::Migration
  def change
    create_table :forum_threads do |t|
      t.string :ForumCategories
      t.string :ForumPosts

      t.timestamps null: false
    end
  end
end
