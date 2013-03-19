class Scope
  # base class for scopes such as private, public etc

  include Mongoid::Document

	field :key, :type => String
  field :name, :type => String
	field :list, :type => Array #allowed elements are: :self, :admin, :user, :unauthorized

	validates_uniqueness_of :key

  #no mappings needed! (yet)

end