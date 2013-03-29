class ActorType

  include Mongoid::Document

  field :name, :type => String, :localize => true
  field :key, :type => Symbol

  validates_uniqueness_of :key

  has_many :information_type_decorators, class_name: 'InformationTypeDecorator', inverse_of: :actor_type


  def self.find_by_key(key)
    ActorType.find_by(key: key)
  end

  def to_s
    self.name
  end

  # Returns list with all information types of this actor type without the decorator
  def information_types
    information_types = Array.new
    information_type_decorators.each do |decorator|
      information_types.push(decorator.information_type)
    end
    information_types
  end

  def decorator_by_key(key)
    information_type_decorators.select{|info_type_decorator| info_type_decorator.information_type == InformationType.find_by_key(key) }.first
  end

end