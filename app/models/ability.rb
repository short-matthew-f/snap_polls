class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    
    can [:active, :completed, :complete, :show], Poll
    
    if user.instructor?
      can [:new, :create], Poll
    end
  end
end
