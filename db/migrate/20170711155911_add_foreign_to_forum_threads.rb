class AddForeignToForumThreads < ActiveRecord::Migration
  def change
    add_reference :forum_threads, :forum_category, index: true, foreign_key: true
  end
end
