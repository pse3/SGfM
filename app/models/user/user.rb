class User

  include Mongoid::Document

  #todo (Kenneth)

  embeds_many :actors, class_name => 'Actor::Actor', inverse_of => :owner             #embedded
  has_many :created, class_name => 'Information::Information', inverse_of => :creator #referenced

end