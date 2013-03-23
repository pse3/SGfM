class Actor
  # base class for hospitals, doctors etc.

  include Mongoid::Document
	include ActiveModel::Validations

  field :created_at, :type => DateTime

  belongs_to :actor_type, class_name: 'ActorType', inverse_of: nil                   #referenced
  embeds_many :informations, class_name: 'Information'                                  #embedded
  belongs_to :owner, class_name: 'User'                                                 #embedded

  #todo: proper validation, not every information has to be set
	#validates :informations, informations_not_empty: true

  def initialize
    super
    self.created_at = DateTime.now
  end

  def find_information_by_key(key)
    self.informations.detect{ |info| info.information_type.key == key }
  end

  def to_s
    return find_information_by_key(:company) unless find_information_by_key(:company).nil?
    return self.find_information_by_key(:last_name).to_s + ' ' + find_information_by_key(:first_name).to_s
  end

end