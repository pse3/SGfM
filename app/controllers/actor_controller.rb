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
  end

  def new
	end

	def information_types_for_actor_type
		render :partial => 'actor/new_actor_information_types', :locals => {:actor_type_key => params[:actor_type_key]}
	end

end