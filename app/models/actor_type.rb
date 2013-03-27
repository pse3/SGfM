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

  ##
  # returns name of actor_type object in lang
  def name_locale(lang)
    current_lang = I18n.locale
    I18n.locale = lang
    locale = self.name
    I18n.locale = current_lang
    locale
  end

  def every_information_type
    info_types = Array.new
    for info_type in information_type do
      info_types.push(info_type.information_type)
    end
    info_types
  end

  def decorator_by_key(key)        #THIS FUCKER SHOULD GIVE ME AN InformationTypeObject BUT IT GIVES ME NilObject
    array = information_type_decorators.select{|info_type_decorator| info_type_decorator.information_type == InformationType.find_by_key(key) }
    array.first
  end

end