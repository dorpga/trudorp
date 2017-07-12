class User < ActiveRecord::Base
  rolify

  after_create :assign_default_role

  has_many :forum_posts
  has_many :posts

  def assign_default_role
    self.add_role(:newuser) if self.roles.blank?
  end

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100#" }, :validate_media_type => false, :default_url => "/images/:style/missing.png"
  do_not_validate_attachment_file_type :avatar

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
