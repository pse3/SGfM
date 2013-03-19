class Relationship

  include Mongoid::Document

  field :comment, :type => String

  field :created_at, :type => DateTime
  field :changed_a, :type => DateTime

  belongs_to :creator, class_name: 'User', inverse_of: nil                                #referenced  / one way relationship                                                                                                                                                                                                                                                 #embedded
  belongs_to :relationship_type, class_name: 'RelationshipType', inverse_of: nil          #referenced  / one way relationship
  belongs_to :scope, class_name: 'Scope', inverse_of: nil                                 #referenced
  embedded_in :actor, class_name: 'Actor'                                                 #embedded
  has_one :reference, class_name: 'Actor'

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