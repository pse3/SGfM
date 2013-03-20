class Information
  # base class for the actual data

  include Mongoid::Document

  field :value, :type => String

  field :created_at, :type => DateTime
  field :changed_a, :type => DateTime

  belongs_to :creator, class_name: 'User', inverse_of: nil                              #referenced  / one way relationship                                                                                                                                                                                                                                                 #embedded
  belongs_to :information_type, class_name: 'InformationType', inverse_of: nil          #referenced  / one way relationship
  belongs_to :scope, class_name: 'Scope', inverse_of: nil                                                   #referenced
  embedded_in :actor, class_name: 'Actor'                                               #embedded

  def initialize
    super
    self.created_at = DateTime.now
  end

  def to_s
    self.value
  end

  def name
    self.information_type.name
  end

  def key
    self.information_type.key
  end


end