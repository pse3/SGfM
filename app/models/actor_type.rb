class ActorType

  include Mongoid::Document

  field :name, :type => String

  has_many :actors, class_name: 'Actor', inverse_of: :actor_type             #referenced
  has_and_belongs_to_many :information_type, class_name: 'InformationType'    #referenced
end