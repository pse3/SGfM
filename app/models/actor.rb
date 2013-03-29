# Base class for hospitals, doctors etc.
class Actor

  include Mongoid::Document
	include ActiveModel::Validations
  include Mongoid::Search

  # More informations about this search gem: https://github.com/mauriciozaffari/mongoid_search
  # Search with: Actor.full_text_search("Suchbegriff", match: :all)

  field :created_at, :type => DateTime
  field :search_field

  belongs_to :actor_type, class_name: 'ActorType', inverse_of: nil                      #referenced
  embeds_many :informations, class_name: 'Information'                                  #embedded
  has_many :relationships, class_name: 'Relationship'                                  	#embedded
  belongs_to :owner, class_name: 'User'                                                 #embedded

	#validates :informations, informations_not_empty: true #TODO: Do not forget to enable validation again. It's disabled for testing purposes only

  before_save :update_search_field
  search_in :search_field


  def initialize
    super
    self.created_at = DateTime.now
  end

  def find_information_by_key(key)
    self.informations.detect{ |information| information.information_type_decorator.key == key }
	end

  def find_relationship_by_key(key)
    self.relationship.detect{ |relationship| relationship.relationship_type.key == key }
  end

  # todo this solution maybe too much datebase hungry?
  def to_s
    final_parsed = self.actor_type.to_string
    informations.each do |information|
      final_parsed = final_parsed.gsub("|:#{information.information_type.key.to_s}|", information.value_to_s)
    end
    final_parsed
  end

  #TODO: At the moment, every information is added to the search_field; in the future only information that is labelled as "searchable" must be added to the searchfield
  def update_search_field
    self.search_field = ''
    self.informations.each { |info| self.search_field += info.value_to_s }
  end

end