class ActorController < ApplicationController
  before_filter :authenticate_login!

  def create
    user = current_login.account
    @actor = Actor.new
    @actor.name = params[:actor][:name]
    @actor.actor_type = ActorType.find_by_key(params[:actor][:actor_type].to_sym)
    user.actors.push @actor
    current_actor = @actor
    user.save
  end

  def list
    @actors = current_login.account.actors
    if @actors.nil?
      return Array.new
    end
  end

  def new
  end

  def show
    @actor = Actor.find(params[:id])
  end


  def reset_default_types
    Actor.delete_all
  end

end