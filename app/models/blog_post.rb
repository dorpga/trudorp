class BlogPost < ActiveRecord::Base
  has_many :blog_taggings
  has_many :blog_comments
  has_many :blog_tags, through: :blog_taggings
  belongs_to :user

  def all_tags=(names)
    self.blog_tags = names.split(",").map do |name|
      BlogTag.where(name: name.strip).first_or_create!
    end
  end

  def all_tags
    self.blog_tags.map(&:name).join(", ")
  end

  def to_param
    slug
  end
end
