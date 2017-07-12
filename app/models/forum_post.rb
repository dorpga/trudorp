class ForumPost < ActiveRecord::Base
  resourcify
  
  belongs_to :forum_thread
  belongs_to :user
end
