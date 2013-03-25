class Information
  # base class for the actual data

  include Mongoid::Document
  include Scoped

  field :value, :type => String

  field :created_at, :type => DateTime
  field :changed_at, :type => DateTime

  belongs_to :creator, class_name: 'User', inverse_of: nil                              #referenced  / one way relationship                                                                                                                                                                                                                                                 #embedded
  belongs_to :information_type, class_name: 'InformationType', inverse_of: nil          #referenced  / one way relationship
  embedded_in :actor, class_name: 'Actor'                                               #embedded

  inherit_scope_from :information_type

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