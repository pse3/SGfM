class Information
  # base class for the actual data

  include Mongoid::Document

  field :value, type :String
  field :created, type :Timestamps

  belongs_to :creator, class_name => 'User::User'                               #referenced
  embedded_in :actor, class_name => 'Actor::Actor'                              #embedded                                                                                                                                                                                                                                                      #embedded
  belongs_to :information_type, class_name => 'Information::InformationType'    #referenced
  belongs_to :scope, class_name => 'Scope::Scope'                               #referenced

end