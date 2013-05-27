# A Relationship represents a relation between two Actor objects, with one active Actor :actor that created the Relationship and
# a second Actor that is only one-way referred in the Relationship as :reference.
# Every Relationship must reference a RelationshipType and contain a comment(can be empty).
class Relationship

  include Mongoid::Document
	include Scoped

	field :comment, :type => String
  field :created_at, :type => DateTime
  field :changed_a, :type => DateTime

  belongs_to :creator, :class_name => 'User', :inverse_of => nil                                #referenced / one-way                                                                                                                                                                                                                                              #embedded
  belongs_to :relationship_type, :class_name => 'RelationshipType', :inverse_of => nil          #referenced / one-way
  belongs_to :scope, :class_name => 'Scope', :inverse_of => nil                                 #referenced / one-way
  belongs_to :actor, :class_name => 'Actor', :inverse_of => :relationships                      #referenced
  belongs_to :reference, :class_name => 'Actor', :inverse_of => nil                             #referenced / one-way

	validates_presence_of :relationship_type, :actor, :reference

  def initialize
    super
    self.created_at = DateTime.now
  end

  def to_s
    "#{self.reference.to_s} | #{self.comment}"
  end

  def name
    self.relationship_type.name
  end

  def key
    self.relationship_type.key
  end

end