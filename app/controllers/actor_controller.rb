class ActorController < ActionController::Base
  before_filter :authenticate_login!

  def create
    user = current_login.account
    @actor = Actor.new
    @actor.name = params[:name]
    @actor.actor_type = ActorType.find_by_key(params[:key].to_sym)
    user.actors.push @actor
    current_actor = @actor
    user.save
  end

  def list_actors
    @actors = current_login.account.actors
  end

  def find_actor_by_id(id)
    @current_actor = actor.find(id)
    @current_actor
  end

end