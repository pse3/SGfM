class InformationType

  include Mongoid::Document

  field :name, type :String

  has_many :informations, class_name => 'Information::Information', inverse_of => :information_type   #referenced
  has_and_belongs_to :actor_type, class_name => 'Actor::ActorType'                                    #referenced

end