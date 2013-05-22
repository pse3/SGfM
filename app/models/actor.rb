# An Actor consists of a list of references to Information objects and a reference to one specific ActorType.
# Actor objects are the main objects in the data model.
# The only core data an Actor contains is its name.
class Actor

  include Mongoid::Document
	include ActiveModel::Validations
  include Mongoid::Search

  # More informations about this search gem: https://github.com/mauriciozaffari/mongoid_search
  # Search with: Actor.full_text_search("Suchbegriff", match: :all)

  field :created_at, :type => DateTime
  field :search_field, :type => String
  field :to_string_field, :type => String

	belongs_to :actor_type, class_name: 'ActorType', inverse_of: nil                      #referenced /one-way
  embeds_many :informations, class_name: 'Information'                                  #embedded
  has_many :relationships, class_name: 'Relationship'                                  	#referenced
  belongs_to :owner, class_name: 'User'                                                 #referenced

  before_save :update_search_field, :update_to_string_field
  search_in :search_field

	#validates_presence_of :actor_type, :owner Todo: doesnt work -.-

  def initialize
    super
    self.created_at = DateTime.now
  end

  def find_information_by_key(key)
    self.informations.detect{ |information| information.information_type_decorator.key == key }
	end

  def find_relationship_by_key(key)
    self.relationships.detect{ |relationship| relationship.relationship_type.key == key }
  end

  def to_s
    to_string_field
  end

  def update_to_string_field
    final_parsed = self.actor_type.to_string_pattern
    informations.each do |information|
      final_parsed = final_parsed.gsub("|:#{information.information_type.key.to_s}|", information.value_to_s) if information.visible?(:User)
    end
    self.to_string_field = final_parsed
  end

  def update_search_field
    self.search_field = ''
    self.informations.each do |information|
      if information.searchable? and information.visible?(:User)
        self.search_field += information.value_to_s
      end
    end
  end

end