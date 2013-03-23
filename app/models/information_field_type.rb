class InformationFieldType

  include Mongoid::Document


  field :key, :type => Symbol


  validates_uniqueness_of :key


  def self.find_by_key(key)
    InformationFieldType.find_by(key: key)
  end

  #Dummy
  def parse(value)
  end

  #Dummy
  def to_s(value)
  end

  #Dummy
  def value(value)
  end

  #Dummy
  def value=(value)
  end


end