# Represents a Scope - a Scope can be attributed to Information, Relationship, etc, objects. It describes kind of a visibility filter. This class is meant to
# be extended. Extending classes need to implement the visible? method, which decides about visibility dependent on viewer, viewee and the field "list".
class Scope
	#TODO: Implement validator
  include Mongoid::Document

	field :key, :type => String
  field :name, :type => String, :localize => true
	field :list, :type => Array #allowed elements are: :Self and all possible account types (e.g. :Admin, :User, ...)

	validates_uniqueness_of :key
	validates_presence_of :name
	validate :list_elements_proper

	# Returns all types of Scope in a list. (That means it returns the Class-Objects).
	def self.all_types
		 Scope.descendants
  end

	#validations

	# Elements of "list" must be either :Self, :Unauthorized or an account type.
	def list_elements_proper
		allowed_elems =  [:Self, :Unauthorized] + Login.account_types.collect {|elem| elem.to_sym}
		unless list.all? { |elem| allowed_elems.include? elem}
			errors[:list] = "List elements aren't correct."
		end
	end
end