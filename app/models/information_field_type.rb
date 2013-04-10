class InformationFieldType

  include Mongoid::Document

  field :key, :type => Symbol
  field :name, :type => String, :localize => true

  validates_uniqueness_of :key
	validates_presence_of :name

  def parse_data(data)
    #just implementing for children
  end

  def self.find_by_key(key)
    InformationFieldType.find_by(key: key)
  end

end