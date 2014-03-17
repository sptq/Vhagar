class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    @user = user || User.new # for guest
    @user.user_role.to_s.split(' ').each { |role| send(role) }

    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/bryanrite/cancancan/wiki/Defining-Abilities
  end

  def guest
  end

  def user
    cannot :manage, User
    cannot :manage, Lecture
    can :read, Lecture
  end

  def staff
    user

    can :manage, User
    can :see_role, User
    cannot :create, User
    cannot :promote, User
    cannot :destroy, User

    can :manage, Lecture
    cannot :destroy, Lecture
  end

  def admin
    staff

    can :manage, :all
    can :promote, User
  end
end