# Base class for hospitals, doctors etc.
class Actor

  include Mongoid::Document
	include ActiveModel::Validations
  include Mongoid::Search

  # More informations about this search gem: https://github.com/mauriciozaffari/mongoid_search
  # Search with: Actor.full_text_search("Suchbegriff", match: :all)

  field :created_at, :type => DateTime
  field :search_field, :type => String
  field :to_string_field, :type => String

  belongs_to :actor_type, class_name: 'ActorType', inverse_of: nil                      #referenced
  embeds_many :informations, class_name: 'Information'                                  #embedded
  has_many :relationships, class_name: 'Relationship'                                  	#embedded
  belongs_to :owner, class_name: 'User'                                                 #embedded

	validates_presence_of :search_field, :to_string_field, :actor_type, :owner

  before_save :update_search_field, :update_to_string_field
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

  def to_s
    to_string_field
  end

  def update_to_string_field
    final_parsed = self.actor_type.to_string_pattern
    informations.each do |information|
      final_parsed = final_parsed.gsub("|:#{information.information_type.key.to_s}|", information.value_to_s)
    end
    self.to_string_field = final_parsed
  end

  # todo maybe it not updated correctly when called via actor_type's after_save, maybe
  def update_search_field
    self.search_field = ''
    self.informations.each do |information|
      if information.searchable? and information.visible?(:User)
        self.search_field += information.value_to_s
      end
    end
  end

end