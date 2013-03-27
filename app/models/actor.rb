class Actor
  # base class for hospitals, doctors etc.

  include Mongoid::Document
	include ActiveModel::Validations
  include Mongoid::Search
  # More informations about this search gem: https://github.com/mauriciozaffari/mongoid_search
  # Search with: Actor.full_text_search("Suchbegriff", match: :all)

  field :created_at, :type => DateTime
  field :searchfield
  field :to_string_field

  belongs_to :actor_type, class_name: 'ActorType', inverse_of: nil                      #referenced
  embeds_many :informations, class_name: 'Information'                                  #embedded
  has_many :relationships, class_name: 'Relationship'                                	#embedded
  belongs_to :owner, class_name: 'User'                                                 #embedded

	#validates :informations, informations_not_empty: true #TODO: Do not forget to enable validation again. It's disabled for testing purposes only

  #Please note: 'before_save' MUST be written BEFORE "search_in"
  before_save :update_searchfield_and_to_string_field
  search_in :searchfield

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

  def update_searchfield_and_to_string_field
    update_to_string_field
    update_searchfield
  end

  def update_to_string_field
      self.to_string_field = ""
      #TODO: At the moment, every information is added to the to_string_field; in the future
      #only information that is labelled as "toString" must be added to the to_string_field
      self.informations.each { |info| self.to_string_field = self.to_string_field + info.value_to_s }
  end

  def update_searchfield
    self.searchfield = ""
    #TODO: At the moment, every information is added to the searchfield; in the future
    #only information that is labelled as "searchable" must be added to the searchfield
    self.informations.each { |info| self.searchfield = self.searchfield + info.value_to_s }
  end

end