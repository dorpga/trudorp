class ForumCategory < ActiveRecord::Base
  has_many :forum_threads, :dependent => :destroy

  def most_recent_thread
    thread = ForumThread.where(forum_category_id: self.id).last()
    return thread
  end
end
