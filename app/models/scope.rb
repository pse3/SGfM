# Represents a scope - a scope can be attributed to Informations, Relations, etc. It describes kind of a visibility filter. This class is meant to
# be extended. Extending classes need to implement the visible? method, which decides about visibility dependent on viewer, viewee and the field "list".
class Scope
	#TODO: Implement validator
  include Mongoid::Document
	field :key, :type => String
  field :name, :type => String, :localize => true
	field :list, :type => Array #allowed elements are: :Self and all possible account types (e.g. :Admin, :User, ...)

	validates_uniqueness_of :key

  #no mappings needed! (yet)

	#Returns all types of scopes in a list. (That means it returns the Class-Objects)
	def self.all_types
		 Scope.descendants
	end
end