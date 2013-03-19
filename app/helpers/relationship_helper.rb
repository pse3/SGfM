module RelationshipHelper

  def relationship_types
    @relationship_types = RelationshipType.all
  end

end