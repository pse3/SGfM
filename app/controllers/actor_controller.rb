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

  def list
    @actors = current_login.account.actors
  end

  def new
  end

end