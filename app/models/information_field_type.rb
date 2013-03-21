class InformationFieldType

  include Mongoid::Document


  field :key, :type => Symbol
  field :single, :type => Boolean


  validates_uniqueness_of :key


  def self.find_by_key(key)
    InformationFieldType.find_by(key: key)
  end

  def single?
    self.single
  end

end