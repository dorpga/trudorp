class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.has_role? :admin
      can :manage, :all
    else
      can :read, :all
      can :create, ForumPost
      can :create, ForumThread
      can :update, ForumPost, :id => ForumPost.with_role(:creator, user).pluck(:id)
    end
  end
end
