class Ability
  include CanCan::Ability

  def initialize(user)
    if user
      if user.has_role? :admin
        can :manage, :all
      else
        can :read, :all
        can :create, ForumPost
        can :create, ForumThread
        can :update, ForumPost, :id => ForumPost.where(user: user).pluck(:id)
        can :destroy, ForumPost, :id => ForumPost.where(user: user).pluck(:id)
      end
    end
  end
end
