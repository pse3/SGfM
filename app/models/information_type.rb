class InformationType

  include Mongoid::Document

  field :name, :type => String, :localize => true
  field :key, :type => Symbol

  validates_uniqueness_of :key

	belongs_to :predefined_scope, class_name: 'Scope', inverse_of: nil #so admins have the possibility to predefine scopes for i-types (e.g. "name has to be public")

  def self.find_by_key(key)
    InformationType.find_by(key: key)
  end

  def referenced(information)
    information.scope= predefined_scope if predefined_scope and not information.scope
  end
end