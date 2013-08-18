class Ability
  include CanCan::Ability

  def initialize(user)
	  user ||= User.new # guest user
    if user.role? :admin
      can :manage, :all
	  else
		  can :manage, :display
      #can :update_hood, :users 
    end
  end
end
