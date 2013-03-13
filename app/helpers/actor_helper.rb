module ActorHelper

  def find_actor_by_id(id)
    @current_actor = Actor.find(id)
  end

end