class InformationType

  include Mongoid::Document

  field :name, :type => String
  field :key, :type => Symbol

  #no mappings needed!

  def self.find_by_key(key)
    InformationType.find_by(key: key)
  end

end