class ActorController < ApplicationController

  before_filter :authenticate_login!

  # Creates a Actor with chosen name and type
  def create
    user = current_login.account
    @actor = Actor.new
    @actor.name = params[:actor][:name]
    @actor.actor_type = ActorType.find_by_key(params[:actor][:actor_type].to_sym)
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

  # Find actor with given id
  def show
    @actor = Actor.find(params[:id])
  end


  # Resets 'Actor' in DataBase
  def reset_default_types
    Actor.delete_all
  end

end