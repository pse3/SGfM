module ActorTypeHelper

  def list_actor_types
    @actor_types = ActorType.each
  end

  def list_information_types_of_actor_type
    @information_types_of_actor_type = ActorType.InformationType
  end

end