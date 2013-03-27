class InformationType

  include Mongoid::Document
  include Scoped

  field :name, :type => String, :localize => true
  field :key, :type => Symbol
  field :data, :type => Array, :localize => true # Store data that the information_field_type may can chose from *like list of tags*


  validates_uniqueness_of :key

  belongs_to :information_field_type, class_name: 'InformationFieldType', inverse_of: nil  #referenced  / one way relationship

  #no mappings needed!

  def self.find_by_key(key)
    InformationType.find_by(key: key)
  end
end