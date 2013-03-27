class RelationshipType

  include Mongoid::Document

  field :name, :type => String, :localize => true
  field :key, :type => Symbol

  validates_uniqueness_of :key

  #no mappings needed!

  def self.find_by_key(key)
    RelationshipType.find_by(key: key)
  end

  def to_s
    self.name.to_s
  end

  # Returns name of actor_type object in lang
  def name_locale(lang)
    current_lang = I18n.locale
    I18n.locale = lang
    name = self.name
    I18n.locale = current_lang
    name
  end

end