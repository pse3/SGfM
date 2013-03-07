class Scope
  # base class for scopes such as private, public etc

  include Mongoid::Document

  field :name, type :String

  has_many :informations, class_name => 'Information::Information', inverse_of => :scope  #referenced

end