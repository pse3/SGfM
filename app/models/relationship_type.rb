class RelationshipType

  include Mongoid::Document

  field :name, :type => String, :localize => true
  field :key, :type => Symbol

  validates_uniqueness_of :key

  #no mappings needed!

  def self.find_by_key(key)
    RelationshipType.find_by(key: key)
  end

end