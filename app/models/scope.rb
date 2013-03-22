class Scope
  # base class for scopes such as private, public etc
	#TODO: Implement validator
  include Mongoid::Document
	field :key, :type => String
  field :name, :type => String  #TODO: need to localize :name
	field :list, :type => Array #allowed elements are: :Self and all possible account types (e.g. :Admin, :User, ...)

	validates_uniqueness_of :key

  #no mappings needed! (yet)

	#Returns all types of scopes in a list.
	def self.all_types
		#TODO maybe using '_type' directly isn't really beautiful - Might have to 'implement' a separate field for that. (pro: localizability)
		Scope.all.distinct("_type")
	end
end