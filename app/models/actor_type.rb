class ActorType

  include Mongoid::Document

  field :name, :type => String
  field :key, :type => Symbol

  validates_uniqueness_of :key

  has_and_belongs_to_many :information_type, class_name: 'InformationType'    #referenced

  def self.find_by_key(key)
    ActorType.find_by(key: key)
  end

  def to_s
    self.name
  end

end