# Base class for the actual data
class Information
  include Mongoid::Document

  field :shit_value # todo needed to name this different otherwise its not clear what self.value is aiming for, do you know how to solve that?

  field :created_at, :type => DateTime
  field :changed_a, :type => DateTime

  belongs_to :creator, class_name: 'User', inverse_of: nil                              #referenced  / one way relationship                                                                                                                                                                                                                                                 #embedded
  belongs_to :information_type, class_name: 'InformationType', inverse_of: nil          #referenced  / one way relationship
  belongs_to :scope, class_name: 'Scope', inverse_of: nil                               #referenced
  embedded_in :actor, class_name: 'Actor'                                               #embedded


  def initialize
    super
    self.created_at = DateTime.now
  end

  def value
    self.information_type.information_field_type.get_value(self.shit_value)
  end

  def value=(value)
    self.shit_value = self.information_type.information_field_type.set_value(value)
  end

  def to_s
    self.value
  end

end