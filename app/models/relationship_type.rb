class RelationshipType

  include Mongoid::Document

  field :name, :type => String, :localize => true
  field :key, :type => Symbol

  validates_uniqueness_of :key

  def self.find_by_key(key)
    RelationshipType.find_by(key: key)
  end

  def to_s
    self.name.to_s
  end

end