module ActorTypeHelper

  def list_actor_types
    @actor_types = ActorType.each
  end

  # WTF is this shit?
  def list_information_types_of_actor_type
    @information_types_of_actor_type = ActorType.InformationType
  end

end