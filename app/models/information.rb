class Information
  # base class for the actual data

  include Mongoid::Document

  field :value, :type => String

  field :created_at, :type => DateTime
  field :changed_a, :type => DateTime

  belongs_to :creator, class_name: 'User', inverse_of: nil          #referenced  / one way relationship                                                                                                                                                                                                                                                 #embedded
  has_one :information_type, class_name: 'InformationType'          #referenced
  has_one :scope, class_name: 'Scope'                               #referenced

  def initialize
    super
    self.created_at = DateTime.now
  end


end