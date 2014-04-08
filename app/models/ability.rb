class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    @user = user || User.new(id: SecureRandom.uuid, user_role: 'guest') # for guest
    @user.user_role ||= 'guest'
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
    cannot :read, Lecture
    cannot :read, Room
    cannot :see_profile, User
  end

  def user
    can :read, Lecture
    can :read, Room
    can :ztmTicket, User

    cannot :see_participants, Lecture

    can :attend, Lecture do |lecture|
      @user.profile and 0 < lecture.available_places and lecture.participants.exclude? @user
    end

    can :resign, Lecture do |lecture|
      lecture.participants.include? @user
    end

    can :manage, Profile
  end

  def staff
    user

    can :manage, User
    can :see_role, User
    can :see_profile, User do |u|
        u.profile != nil
    end

    cannot :create, User
    cannot :promote, User
    cannot :destroy, User

    can :manage, Lecture
    can :see_participants, Lecture
    cannot :destroy, Lecture
    cannot :attend, Lecture
    cannot :resign, Lecture

    can :remove, Lecture
    can :modify, Lecture

    can :manage, Room
    cannot :destroy, Room
  end

  def admin
    staff

    can :read, :all
    can :manage, :all
    can :promote, User
    cannot :attend, Lecture
    cannot :resign, Lecture
  end
end
