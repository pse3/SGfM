class ActorController < ApplicationController

  before_filter :authenticate_login!

  # Creates a Actor with chosen name and type
  def create
    user = current_login.account
    @actor = Actor.new
    @actor.name = params[:actor][:name]
    @actor.actor_type = ActorType.find_by_key(params[:actor][:actor_type_key].to_sym)
    user.actors.push @actor
    current_actor = @actor
    user.save
  end

  # Gets all actors of the current logged in user
  # If there are none, return an empty array
  def list
    @actors = current_login.account.actors
    if @actors.nil?
      return Array.new
    end
  end

  # Doesn't do anything
  def new
	end

	def information_types_for_actor_type
    key = params[:actor_type_key]
    actor_type = ActorType.find_by_key(key)
		information_types =  actor_type.information_type
    render :partial => 'actor/new_actor_information_types', :locals => {:actor_type_key => key,
                                                                        :actor_type => actor_type,
																																				:information_types => information_types
		}
	end

  # Find actor with given id
  def show
    @actor = Actor.find(params[:id])
  end

end