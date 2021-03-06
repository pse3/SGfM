# ActorTypes define which Information objects of which InformationType objects an Actor with this ActorType needs to contain.
# InformationTypeDecorator objects of these InformationTypes are referenced in ActorType.
# The only core data an ActorType contains is its name.
class ActorType

  include Mongoid::Document

  field :name, :type => String, :localize => true
  field :key, :type => Symbol
  field :to_string_pattern, :type => String

  has_many :information_type_decorators, class_name: 'InformationTypeDecorator', inverse_of: :actor_type    #referenced
  has_and_belongs_to_many :predefined_questions, class_name: 'RelationshipType', inverse_of: :actor_types   #referenced

  after_save :update_corresponding_actors


	validates_uniqueness_of :key
	validates_presence_of :name, :to_string_pattern
	#validates_format_of :to_string_pattern, :with => /(\|:.+\|( )*)*/ Doesn't seem to work. No idea why.

  def self.find_by_key(key)
    ActorType.find_by(key: key)
  end

  def to_s
    self.name
  end

  # Returns list with all InformationType objects of this Actor type without the decorator.
  def information_types
    information_types = Array.new
    information_type_decorators.each do |decorator|
      information_types.push(decorator.information_type)
    end
    information_types
  end

  # Returns the InformationTypeDecorator that decorates the InformationType with given key.
  def decorator_by_key(key)
    information_type_decorators.select{|info_type_decorator| info_type_decorator.information_type == InformationType.find_by_key(key) }.first
  end

  # Saves each Actor that uses this ActorType to activate update methods of Actor (e.g. before_save).
  def update_corresponding_actors
    corresponding_actors = Actor.where(:actor_type => self)
    corresponding_actors.each do |actor|
      actor.save
    end
  end

end