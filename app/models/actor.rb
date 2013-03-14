class Actor
  # base class for hospitals, doctors etc.

  include Mongoid::Document
	include ActiveModel::Validations

  field :created_at, :type => DateTime

  belongs_to :actor_type, class_name: 'ActorType', inverse_of: nil                      #referenced
  embeds_many :informations, class_name: 'Information'                                  #embedded
  belongs_to :owner, class_name: 'User'                                                 #embedded

	validates_with	ActorValidator
  def initialize
    super
    self.created_at = DateTime.now
  end

  #TODO refactor...
  def find_information_by_key(key)
    infos_by_type = self.informations.select { |info|
      info.information_type.key == key
    }
    infos_by_type.first unless infos_by_type.empty?
  end

  def name
    self.find_information_by_key(:name)
  end

end