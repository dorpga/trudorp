class ForumThread < ActiveRecord::Base
  belongs_to :forum_category
  has_many :forum_posts, :dependent => :destroy
end
