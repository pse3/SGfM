class RelationshipType

  include Mongoid::Document

  field :name, :type => String, :localize => true
  field :key, :type => Symbol
  field :question, :type => String, :localize => true

  validates_uniqueness_of :key
	validates_presence_of :name, :question

  def self.find_by_key(key)
    RelationshipType.find_by(key: key)
  end

  def to_s
    self.name.to_s
  end

end