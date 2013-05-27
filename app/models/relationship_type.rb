# RelationshipType objects are referenced by Relationship objects.
# A RelationshipType consists of a :name and :key.
# Each RelationshipType also has a predefined :question that is asked specifically when a Relationship of this RelationshipType is created.
class RelationshipType

  include Mongoid::Document

  field :name, :type => String, :localize => true
  field :key, :type => Symbol
  field :question, :type => String, :localize => true

  has_and_belongs_to_many :actor_types, class_name: 'ActorType', inverse_of: :predefined_questions  #referenced

  validates_uniqueness_of :key
	validates_presence_of :name, :question

  def self.find_by_key(key)
    RelationshipType.find_by(key: key)
  end

  def to_s
    self.name.to_s
  end

end