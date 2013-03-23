class Information
  # base class for the actual data

  include Mongoid::Document

  field :value

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
    self.information_type.information_field_type.to_s(value)
  end

  def value
    self.information_type.information_field_type.parse(self.value)
  end

  def value=(value)
    self.value = self.information_type.information_field_type.value=(value)
  end

end