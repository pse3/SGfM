class ActorType

  include Mongoid::Document

  field :name, :type => String, :localize => true
  field :key, :type => Symbol

  validates_uniqueness_of :key

  has_and_belongs_to_many :information_type, class_name: 'InformationType'    #referenced
  def self.find_by_key(key)
    ActorType.find_by(key: key)
  end

  def to_s
    self.name
  end

  ##
  # returns name of actor_type object in english
  def name_en
    temp_lang = I18n.locale
    I18n.locale = :en
    en = self.name
    I18n.locale = temp_lang
    en
  end

  ##
  # returns name of actor_type object in german
  def name_de
    temp_lang = I18n.locale
    I18n.locale = :de
    de = self.name
    I18n.locale = temp_lang
    de
  end

  ##
  # returns name of actor_type object in french
  def name_fr
    temp_lang = I18n.locale
    I18n.locale = :fr
    fr = self.name
    I18n.locale = temp_lang
    fr
  end

  ##
  # returns name of actor_type object in italian
  def name_it
    temp_lang = I18n.locale
    I18n.locale = :it
    it = self.name
    I18n.locale = temp_lang
    it
  end

end