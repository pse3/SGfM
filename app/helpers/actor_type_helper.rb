module ActorTypeHelper

  def list_actor_types
    @actor_types = ActorType.each
  end

end