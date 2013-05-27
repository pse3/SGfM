module ActorHelper

  # Finds Actor.
  def find_actor_by_id(id)
    @current_actor = Actor.find(id)
  end

	def list_scopes
		Scope.all
	end


end