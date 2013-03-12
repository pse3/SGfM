class Actor
  # base class for hospitals, doctors etc.
  include Mongoid::Document

  field :name, :type => String
  field :created_at, :type => DateTime

  belongs_to :actor_type, class_name: 'ActorType', inverse_of: nil                      #referenced
  embeds_many :informations, class_name: 'Information', inverse_of: :actor              #embedded
  belongs_to :owner, class_name: 'User'                                                 #embedded

  def initialize
    super
    self.created_at = DateTime.now
  end
end