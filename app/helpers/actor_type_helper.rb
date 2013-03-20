module ActorTypeHelper

  def list_actor_types
    @actor_types = ActorType.all
  end

	def list_scopes
		Scope.all
	end
end