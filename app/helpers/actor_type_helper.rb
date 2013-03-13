module ActorTypeHelper

  def list_actor_types
    @actor_types = ActorType.each
  end

  def actor_type_by_key(key)
    @actor_type.find_by_key(key)
  end

  # WTF is this shit?
  def list_information_types_of_actor_type
    @information_types_of_actor_type = ActorType.InformationType
  end

end