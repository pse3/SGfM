class Actor
  # base class for hospitals, doctors etc.

  include Mongoid::Document
	include ActiveModel::Validations

  field :created_at, :type => DateTime

  belongs_to :actor_type, class_name: 'ActorType', inverse_of: nil                      #referenced
  embeds_many :informations, class_name: 'Information'                                  #embedded
  has_many :relationships, class_name: 'Relationship'                                	#embedded
  belongs_to :owner, class_name: 'User'                                                 #embedded

	validates :informations, informations_not_empty: true


  def initialize
    super
    self.created_at = DateTime.now
  end

  def find_information_by_key(key)
    self.informations.detect{ |info| info.information_type.key == key }
  end

  def find_relationship_by_key(key)
    self.relationship.detect{ |relationship| relationship.relationship_type.key == key }
  end

  #TODO need to fix this, only temporary to sting method # needs to be type specific
  def to_s
    return find_information_by_key(:company).value_to_s unless find_information_by_key(:company).nil?
    return self.find_information_by_key(:last_name).value_to_s + ' ' + find_information_by_key(:first_name).value_to_s
  end

end