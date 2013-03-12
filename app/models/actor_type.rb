class ActorType

  include Mongoid::Document

  field :name, :type => String
  field :key, :type => Symbol

  has_many :information_type, class_name: 'InformationType'    #referenced

  def self.find_by_key(key)
    ActorType.find_by(key: key)
  end

end