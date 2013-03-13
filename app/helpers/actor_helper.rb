module ActorHelper

  def find_actor_by_id(id)
    @current_actor = actor.find(id)
    @current_actor
  end

end