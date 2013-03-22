class Scope
  # base class for scopes such as private, public etc
	# TODO: This class is meant to be abstract (in means of Java terminology). The actual (instantiable) implementations are: WhitelistScope and BlacklistScope.

  include Mongoid::Document
	field :key, :type => String
  field :name, :type => String  #TODO: need to localize :name
	field :list, :type => Array #allowed elements are: :self, :admin, :user, :unauthorized.

	validates_uniqueness_of :key

  #no mappings needed! (yet)

	#Returns all types of scopes in a list.
	def self.all_types
		#TODO maybe using '_type' directly isn't really beautiful - Might have to 'implement' a separate field for that. (pro: localizability)
		Scope.all.distinct("_type")
	end
end