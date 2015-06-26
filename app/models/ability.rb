class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    if user.admin?
      can :manage, :all
    elsif !user.email.empty?
      can :create, :all do |pc|
        true
      end
      can :read, :all do |pc|
        true
      end
      can :manage, Newsletter
      #can update player if the player is associate with a campaign owned by current user
      can :update, Player, :campaign => { :user_id => user.id }
      #can update player if the player is the current user
      can :update, Player, :user_id => user.id

      #can update character if the player is the current user
      can [:update, :join, :retire, :kill, :remove, :resurrect, :find, :lose, :quit], Character, :user_id => user.id
      #Can update player if they are an assistant on the campaign.
      can [:update, :join, :remove], Character do |char|
        if char.current_campaign.present?
          char.current_campaign.aids.include?(user) || char.current_campaign.gm == user
        end
      end
      #only admin can see version
      cannot :read, Version
      cannot :create, PlayerCharacter do |pc|
        result = true
        #Grab each active player and cycle through
        pc.campaign.players.active.each do |player|
          #set return value to true if the player is the user
          result = false if player.user_id == user.id
        end
        return result
      end

      can :update, Game, :user_id => user.id
      can [:update, :join, :retire, :kill, :remove], PlayerCharacter do |pc|
        pc.campaign.aids.include?(user) 
      end
      can [:update, :attach_event, :add_pc, :remove_pc], Campaign do |campaign|
        (campaign.aids.include?(user) || campaign.gm == user || campaign.players.where(user_id: user.id).present?)
      end
      can :update, Resource, :user_id => user.id
    else
      can :read, :all
      cannot :read, Version
    end


    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
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
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
