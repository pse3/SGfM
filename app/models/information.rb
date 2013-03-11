class Information
  # base class for the actual data

  include Mongoid::Document

  field :value, :type => String
  field :created, :type => DateTime

  belongs_to :creator, class_name: 'User'                               #referenced
  embedded_in :actor, class_name: 'Actor'                              #embedded                                                                                                                                                                                                                                                      #embedded
  belongs_to :information_type, class_name: 'InformationType'    #referenced
  belongs_to :scope, class_name: 'Scope'                               #referenced

end