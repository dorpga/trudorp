class User < ActiveRecord::Base
  rolify

  after_create :assign_default_role

  has_many :forum_posts
  has_many :posts

  def assign_default_role
    self.add_role(:newuser) if self.roles.blank?
  end

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100#" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
