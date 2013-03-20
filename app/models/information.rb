class Information
  # base class for the actual data

  include Mongoid::Document

  field :value, :type => Array

  field :created_at, :type => DateTime
  field :changed_a, :type => DateTime

  belongs_to :creator, class_name: 'User', inverse_of: nil                              #referenced  / one way relationship                                                                                                                                                                                                                                                 #embedded
  belongs_to :information_type, class_name: 'InformationType', inverse_of: nil          #referenced  / one way relationship
  belongs_to :scope, class_name: 'Scope', inverse_of: nil                                                   #referenced
  embedded_in :actor, class_name: 'Actor'                                               #embedded

  def initialize
    super
    self.created_at = DateTime.now
    self.value = Array.new
  end

  #TODO rewrite according to single_value / multiple_value
  def to_s
    self.value
  end

  def name
    self.information_type.name
  end

  def key
    self.information_type.key
  end

  def single_value
     self.value[0]
  end

  def single_value=(newvalue)
    self.value[0]= newvalue
    self.save
  end

  def multiple_value
    .self.value
  end
end