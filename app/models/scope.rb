class Scope
  # base class for scopes such as private, public etc

  include Mongoid::Document

  field :name, :type => String

  #no mappings needed! (yet)

  #something


end