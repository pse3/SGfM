# A relationship represents a relation between to actors, with one active actor :actor that owns the relationship and
# a second actor that is only one-way referred in the relationship as :reference.
# Every relationship must belong to a relationship_type and contain a comment(can be empty)
class Relationship

  include Mongoid::Document

  field :comment, :type => String

  field :created_at, :type => DateTime
  field :changed_a, :type => DateTime

  belongs_to :creator, class_name: 'User', inverse_of: nil                                #referenced  / one way relationship                                                                                                                                                                                                                                                 #embedded
  belongs_to :relationship_type, class_name: 'RelationshipType', inverse_of: nil          #referenced  / one way relationship
  belongs_to :scope, class_name: 'Scope', inverse_of: nil                                 #referenced
  embedded_in :actor, class_name: 'Actor'                                                 #embedded
  belongs_to :reference, class_name: 'Actor', inverse_of: nil                                #referenced  / one way relationship

  def initialize
    super
    self.created_at = DateTime.now
  end

  def to_s
    # hallo patrick ;)
    self.reference.to_s + ' | ' + self.comment
  end

  def name
    self.relationship_type.name
  end

  def key
    self.relationship_type.key
  end


end