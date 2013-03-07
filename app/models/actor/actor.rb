class Actor
  # base class for hospitals, doctors etc.

  include Mongoid::Document

  field :name, type :String

  belongs_to :actor_type, class_name => 'Actor::ActorType'                                        #referenced
  embeds_many :informations, class_name => 'Information::Information', inverse_of => :actor       #embedded
  embedded_in :owner, class_name => 'User::User'                                                  #embedded

end